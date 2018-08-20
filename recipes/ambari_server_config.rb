#
# Cookbook Name:: ambari-chef
# Recipe:: ambari_server_config
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

# set ambari-server file permissions
bash 'set_ambari-server_file_permissions' do
  code <<-EOF
    chown -R #{node['hw']['ambari']['server']['user']['name']}:root /etc/ambari-server
    chown -R #{node['hw']['ambari']['server']['user']['name']}:root /var/lib/ambari-server
    chown -R #{node['hw']['ambari']['server']['user']['name']}:root /var/log/ambari-server
    chown -R #{node['hw']['ambari']['server']['user']['name']}:root /var/run/ambari-server
  EOF
end

# if truststore is enabled
if node['hw']['ambari']['server']['setup']['security']['setup-truststore'] == 'true'
  remote_file 'copy_/var/lib/ambari-server/keys/keystore.jks' do
    path '/var/lib/ambari-server/keys/keystore.jks'
    source "file://#{node['hw']['ambari']['server']['crypto']['truststore_jks']}"
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode 0600
  end
  file 'create_/var/lib/ambari-server/keys/pass.txt' do
    path '/var/lib/ambari-server/keys/pass.txt'
    content node['hw']['ambari']['server']['crypto']['truststore_pass'].to_s
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode '0600'
  end
  remote_file 'copy_/var/lib/ambari-server/keys/ca.crt' do
    path '/var/lib/ambari-server/keys/ca.crt'
    source "file://#{node['hw']['ambari']['server']['crypto']['ca']}"
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode 0600
  end
end

# if https is enabled
if node['hw']['ambari']['server']['config']['ambari.properties']['api.ssl'] == 'true'
  remote_file 'copy_/var/lib/ambari-server/keys/https.crt' do
    path '/var/lib/ambari-server/keys/https.crt'
    source "file://#{node['hw']['ambari']['server']['crypto']['https_cert']}"
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode 0600
  end
  remote_file 'copy_/var/lib/ambari-server/keys/https.key' do
    path '/var/lib/ambari-server/keys/https.key'
    source "file://#{node['hw']['ambari']['server']['crypto']['https_key']}"
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode 0600
  end
  file 'create_/var/lib/ambari-server/keys/https.pass.txt' do
    path '/var/lib/ambari-server/keys/https.pass.txt'
    content node['hw']['ambari']['server']['crypto']['https_key_pass'].to_s
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode '0600'
  end
  remote_file 'copy_/var/lib/ambari-server/keys/https.keystore.p12' do
    path '/var/lib/ambari-server/keys/https.keystore.p12'
    source "file://#{node['hw']['ambari']['server']['crypto']['https_keystore_p12']}"
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode 0600
  end
end

# if ldap is enabled
if node['hw']['ambari']['server']['config']['ambari.properties']['ambari.ldap.isConfigured'] == 'true'
  remote_file 'copy_/var/lib/ambari-server/keys/https.keystore.jks' do
    path '/var/lib/ambari-server/keys/https.keystore.jks'
    source "file://#{node['hw']['ambari']['server']['crypto']['https_keystore_jks']}"
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode 0600
  end
  file 'create_/etc/ambari-server/conf/ldap-password.dat' do
    path '/etc/ambari-server/conf/ldap-password.dat'
    content node['hw']['ambari']['server']['crypto']['ldap_pass'].to_s
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode '0600'
  end
end

# if using custom db
if defined?(node['hw']['ambari']['server']['setup']['db']['databasepassword'])
  file 'create_/etc/ambari-server/conf/password.dat' do
    path '/etc/ambari-server/conf/password.dat'
    content node['hw']['ambari']['server']['setup']['db']['databasepassword'].to_s
    owner node['hw']['ambari']['server']['user']['name']
    group 'root'
    mode '0600'
  end
end

# update ambari with new config
template 'create_/etc/ambari-server/conf/ambari.properties' do
  path '/etc/ambari-server/conf/ambari.properties'
  source "ambari.properties_#{node['hw']['ambari']['version']}.erb"
  sensitive true
  owner node['hw']['ambari']['server']['user']['name']
  group 'root'
end
