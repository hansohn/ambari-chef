#
# Cookbook:: ambari-chef
# Recipe:: ambari_server_service
#
# The MIT License (MIT)
#
# Copyright:: 2018, Ryan Hansohn
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

ambari_version = -> { node['hw']['ambari']['version'] }
ambari_version_full = -> { node['hw']['ambari'][ambari_version.call]['version_full'] }

# stop ambari server if not running correctly
bash 'fix_ambari-server_service' do
  code <<-EOF
    if /usr/bin/grep -q "Ambari Server running" <(/etc/rc.d/init.d/ambari-server status) &&
      /usr/bin/grep -qP "(failed|inactive)" <(/bin/systemctl is-active ambari-server); then
        /etc/init.d/ambari-server stop
        sleep 30
    fi
  EOF
end

# systemctl daemon reload
bash 'systemctl_daemon_reload' do
  code 'systemctl daemon-reload'
  action :nothing
end

# create ambari-server service
template 'create_/etc/rc.d/init.d/ambari-server' do
  path '/etc/rc.d/init.d/ambari-server'
  source "ambari-server.service_#{ambari_version.call}.erb"
  variables(
    'version_full' => ambari_version_full.call
  )
  sensitive true
  owner node['hw']['ambari']['server']['user']['name']
  group 'root'
  notifies :run, 'bash[systemctl_daemon_reload]', :immediately
end

# verify ambari server is up and responding
bash 'verify_ambari_server_is_responding' do
  code <<-EOF
    i=1
    while ! grep -q 8080 <(netstat -anop) && [ $i -lt 12 ]; do
      i=$((i+1))
      sleep 5
    done
  EOF
  action :nothing
end

# start/enable ambari server
service 'start_ambari-server_service' do
  service_name 'ambari-server.service'
  status_command "grep -q 'Ambari Server running' <(/etc/init.d/ambari-server status)"
  action [:start, :enable]
  notifies :run, 'bash[verify_ambari_server_is_responding]', :immediately
end
