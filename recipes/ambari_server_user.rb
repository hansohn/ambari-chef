#
# Cookbook Name:: ambari-chef
# Recipe:: ambari_server_user
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

# create hadoop group
group 'create_hadoop_group' do
  group_name  node['hw']['hadoop']['common']['group']['name']
  gid         node['hw']['hadoop']['common']['group']['gid']
  action      :create
end

# create ambari-server user
if node['hw']['ambari']['server']['user']['name'] != 'root'
  user 'create_ambari_server_user' do
    username    node['hw']['ambari']['server']['user']['name']
    uid         node['hw']['ambari']['server']['user']['uid']
    home        node['hw']['ambari']['server']['user']['home']
    shell       node['hw']['ambari']['server']['user']['shell']
    group       node['hw']['hadoop']['common']['group']['name']
    manage_home true
    action      :create
  end
end

# add ambari-server sudoers file
if node['hw']['ambari']['server']['user']['name'] != 'root'
  template 'create_/etc/sudoers.d/ambari-server' do
    path '/etc/sudoers.d/ambari-server'
    source 'ambari-server.sudoers.erb'
    sensitive true
    owner 'root'
    group 'root'
  end
end
