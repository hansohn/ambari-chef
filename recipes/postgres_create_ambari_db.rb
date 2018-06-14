#
# Cookbook Name:: ambari-chef
# Recipe:: postgres_create_ambari_db
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

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
    'db_tempalte' => 'DEFAULT',
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
