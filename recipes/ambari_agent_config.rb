#
# Cookbook:: ambari-chef
# Recipe:: ambari_agent_config
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

# set ambari-agent file permissions
bash 'set_ambari-agent_file_permissions' do
  code <<-EOF
    chown -R #{node['hw']['ambari']['agent']['user']['name']}:root /etc/ambari-agent
    chown -R #{node['hw']['ambari']['agent']['user']['name']}:root /var/lib/ambari-agent
    chown -R #{node['hw']['ambari']['agent']['user']['name']}:root /var/log/ambari-agent
    chown -R #{node['hw']['ambari']['agent']['user']['name']}:root /var/run/ambari-agent
  EOF
end

# if truststore is enabled
if node['hw']['ambari']['agent']['setup']['security']['setup-truststore'] == 'true'
  remote_file 'copy_/var/lib/ambari-agent/keys/keystore.jks' do
    path '/var/lib/ambari-agent/keys/keystore.jks'
    source "file://#{node['hw']['ambari']['agent']['crypto']['truststore_jks']}"
    owner node['hw']['ambari']['agent']['user']['name']
    group 'root'
    mode '0600'
  end
  remote_file 'copy_/var/lib/ambari-agent/keys/ca.crt' do
    path '/var/lib/ambari-agent/keys/ca.crt'
    source "file://#{node['hw']['ambari']['agent']['crypto']['ca']}"
    owner node['hw']['ambari']['agent']['user']['name']
    group 'root'
    mode '0600'
  end
end

# if two_way_ssl is enabled
if node['hw']['ambari']['server']['config']['ambari.properties']['security.server.two_way_ssl'] == 'true'
  remote_file 'copy_/var/lib/ambari-agent/keys/https.crt' do
    path "/var/lib/ambari-agent/keys/#{node['fqdn']}.crt"
    source "file://#{node['hw']['ambari']['agent']['crypto']['cert']}"
    owner node['hw']['ambari']['agent']['user']['name']
    group 'root'
    mode '0600'
  end
  remote_file 'copy_/var/lib/ambari-agent/keys/https.key' do
    path "/var/lib/ambari-agent/keys/#{node['fqdn']}.key"
    source "file://#{node['hw']['ambari']['agent']['crypto']['key']}"
    owner node['hw']['ambari']['agent']['user']['name']
    group 'root'
    mode '0600'
  end
end

# set ambari_server var based on Chef Search
# set to localhost for Chef-Zero and Chef-Solo
ambari_server = if Chef::Config[:local_mode]
                  node['fqdn']
                else
                  search(:node, 'role:"ambari_server"')
                end

# update ambari with new config
template 'create_/etc/ambari-agent/conf/ambari-agent.ini' do
  path '/etc/ambari-agent/conf/ambari-agent.ini'
  source "ambari-agent.ini_#{ambari_version.call}.erb"
  sensitive true
  owner node['hw']['ambari']['agent']['user']['name']
  group 'root'
  variables('ambari_server' => ambari_server)
end
