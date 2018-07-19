#
# Cookbook Name:: ambari-chef
# Recipe:: ambari_metrics_config
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

# if ams-grafana-ini protocol equals https
if node['hw']['ambari']['metrics']['config']['ams-grafana-ini']['protocol'] == 'https'
  remote_file "copy_#{node['hw']['ambari']['metrics']['crypto']['cert']}" do
    path node['hw']['ambari']['metrics']['crypto']['cert']
    source "file:///etc/pki/tls/certs/#{node['fqdn']}.crt"
    owner node['hw']['ambari']['metrics']['user']['name']
    group 'root'
    mode 0600
  end
  remote_file "copy_#{node['hw']['ambari']['metrics']['crypto']['key']}" do
    path node['hw']['ambari']['metrics']['crypto']['key']
    source "file:///etc/pki/tls/private/#{node['fqdn']}.key"
    owner node['hw']['ambari']['metrics']['user']['name']
    group 'root'
    mode 0600
  end
end
