#
# Cookbook:: ambari-chef
# Recipe:: postgres_create_ambari_db
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
    'db_tempalte' => 'template0',
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
      -f '/tmp/postgres_create_ambari_schema.sql'
  EOF
  user 'postgres'
  action :nothing
  only_if { File.exist?('/tmp/postgres_create_ambari_schema.sql') }
end

# execute
execute 'create_ambari_database' do
  command 'echo "creating ambari database"'
  notifies :create, 'template[create_/tmp/postgres_create_ambari_db.sql]', :immediately
  notifies :run, 'bash[create_ambari_postgres_db]', :immediately
  notifies :create, 'template[create_/tmp/postgres_create_ambari_schema.sql]', :immediately
  notifies :run, 'bash[create_ambari_postgres_schema]', :immediately
end
