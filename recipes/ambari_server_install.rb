#
# Cookbook:: ambari-chef
# Recipe:: ambari_server_install
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

java_version = -> { node['java']['install_version'] }
java_install = -> { node['java']['install_from'] }
ambari_version = -> { node['hw']['ambari']['version'] }
ambari_version_full = -> { node['hw']['ambari'][ambari_version.call]['version_full'] }

# include package(s)
package ['openssl-devel']

# create postgres database
# create /tmp/postgres_create_ambari_db.sql
template 'create_/tmp/postgres_create_ambari_db.sql' do
  path '/tmp/postgres_create_ambari_db.sql'
  source 'postgres_create_ambari_db.sql.erb'
  variables(
    'database' => node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.database_name'],
    'db_username' => node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.user.name'],
    'db_userpass' => node['hw']['ambari']['server']['setup']['db']['databasepassword'],
    'db_schema' => node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.postgres.schema'],
    'db_owner' => node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.user.name'],
    'db_template' => 'template0',
    'db_encoding' => 'UTF8',
    'db_lc_colate' => 'en_US.UTF-8',
    'db_tablespace' => 'DEFAULT',
    'db_connlimit' => '-1'
  )
  sensitive true
  owner 'postgres'
  group 'postgres'
  mode '0600'
  action :nothing
end

# create postgres_create_ambari_db
bash 'create_ambari_postgres_db' do
  code "psql -f '/tmp/postgres_create_ambari_db.sql'"
  user 'postgres'
  action :nothing
  only_if { File.exist?('/tmp/postgres_create_ambari_db.sql') }
end

# populate postgres database
# create /tmp/postgres_create_ambari_schema.sql
template 'create_/tmp/postgres_create_ambari_schema.sql' do
  path '/tmp/postgres_create_ambari_schema.sql'
  source 'postgres_create_ambari_schema.sql.erb'
  sensitive true
  owner 'postgres'
  group 'postgres'
  mode '0600'
  action :nothing
end

# create postgres_create_ambari_schema
bash 'create_ambari_postgres_schema' do
  code <<-EOF
    export PGPASSWORD='#{node['hw']['ambari']['server']['setup']['db']['databasepassword']}'
    psql -U #{node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.user.name']} \
         -d #{node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.database_name']} \
         -h localhost \
         -f '/tmp/postgres_create_ambari_schema.sql'
  EOF
  user 'postgres'
  action :nothing
  only_if { File.exist?('/tmp/postgres_create_ambari_schema.sql') }
end

# install & configure ambari-server
# setup ambari-server
bash 'config_ambari_server' do
  code "ambari-server setup -s \
        --java-home=#{node['java']['setup']['app_dir']}/#{node['java'][java_install.call][java_version.call]['extract_dir']} \
        --database=#{node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.database']} \
        --databasehost=#{node['hw']['ambari']['server']['setup']['db']['databasehost']} \
        --databaseport=#{node['hw']['ambari']['server']['setup']['db']['databaseport']} \
        --databasename=#{node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.database_name']} \
        --databaseusername=#{node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.user.name']} \
        --databasepassword=#{node['hw']['ambari']['server']['setup']['db']['databasepassword']}"
  user 'root'
  group 'root'
  action 'nothing'
end

# install ambari-server
package 'ambari-server' do
  package_name 'ambari-server'
  version ambari_version_full.call
  action :install
  notifies :create, 'template[create_/tmp/postgres_create_ambari_db.sql]', :immediately
  notifies :run, 'bash[create_ambari_postgres_db]', :immediately
  notifies :create, 'template[create_/tmp/postgres_create_ambari_schema.sql]', :immediately
  notifies :run, 'bash[create_ambari_postgres_schema]', :immediately
  notifies :run, 'bash[config_ambari_server]', :immediately
  not_if { ::File.exist?('/etc/rc.d/init.d/ambari-server') }
end
