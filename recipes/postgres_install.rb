#
# Cookbook:: ambari-chef
# Recipe:: postgres_install
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

# initialize default postgresql db
bash 'initialize_postgres_db' do
  code 'postgresql-setup initdb'
  action :nothing
end

# update pg_hba.conf for authentication
template 'create_/var/lib/pgsql/data/pg_hba.conf' do
  path '/var/lib/pgsql/data/pg_hba.conf'
  source 'postgres_pg_hba.conf.erb'
  sensitive true
  owner 'postgres'
  group 'postgres'
  mode '0600'
  action :nothing
end

# install postgresql-server
package 'install_postgres' do
  package_name %w(postgresql-server postgresql-contrib postgresql-devel postgresql-plpython postgresql-jdbc)
  action :install
  notifies :run, 'bash[initialize_postgres_db]', :immediately
  notifies :create, 'template[create_/var/lib/pgsql/data/pg_hba.conf]', :immediately
  notifies :restart, 'service[postgresql]', :immediately
end

# start/enable postgresql service
service 'postgresql' do
  action [:start, :enable]
end
