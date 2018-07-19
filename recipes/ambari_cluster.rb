#
# Cookbook Name:: ambari-chef
# Recipe:: hw_cluster
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

# hw-cluster: create clusters directory
directory 'make_/var/lib/ambari-clusters' do
  path '/var/lib/ambari-clusters'
  recursive true
  owner node['hw']['ambari']['server']['user']['name']
  group 'root'
end

# set ambari_server var based on Chef Search
# set to hostname for Chef-Zero and Chef-Solo
ambari_server = if Chef::Config[:local_mode]
                  node['fqdn']
                else
                  search(:node, 'role:"ambari_server"')
                end

# hw-cluster: upload version definition file to ambari
bash 'upload_hw_vdf' do
  code "curl -k -X POST \
             -H 'X-Requested-By: ambari' \
             -u admin:admin http://#{ambari_server}:#{node['hw']['ambari']['server']['config']['ambari.properties']['client.api.port']}/api/v1/version_definitions \
             -d @HDP-#{node['hw']['hdp']['version_full']}.xml"
  cwd '/var/lib/ambari-clusters'
  only_if { File.exist?("/var/lib/ambari-clusters/HDP-#{node['hw']['hdp']['version_full']}.xml") }
end

# hw-cluster: upload blueprint to ambari
bash 'upload_hw_blueprint' do
  if node['hw']['ambari']['server']['config']['ambari.properties']['api.ssl'] == 'false'
    code "curl -k -X POST \
               -H 'X-Requested-By: ambari' \
               -u admin:admin http://#{ambari_server}:#{node['hw']['ambari']['server']['config']['ambari.properties']['client.api.port']}/api/v1/blueprints/#{node['hw']['cluster']['blueprint_name']} \
               -d @#{node['hw']['cluster']['blueprint_file']}"
  else
    code "curl -k -X POST \
               -H 'X-Requested-By: ambari' \
               -u admin:admin https://#{ambari_server}:#{node['hw']['ambari']['server']['config']['ambari.properties']['client.api.ssl.port']}/api/v1/blueprints/#{node['hw']['cluster']['blueprint_name']} \
               -d @#{node['hw']['cluster']['blueprint_file']}"
  end
  cwd '/var/lib/ambari-clusters'
  only_if { File.exist?("/var/lib/ambari-clusters/#{node['hw']['cluster']['blueprint_file']}") }
end

# hw-cluster: create hw cluster
# ISSUE: depending on the order of nodes processed by a Chef server, it is
#   possible (highly likely) that a race condition can occur where Ambari
#   attempts to build a cluster before required nodes are up. As such, the
#   below command should be ran manually on large clusters once all dependent
#   nodes have been verified as ready to be clusterized.
bash 'create_hw_cluster' do
  if node['hw']['ambari']['server']['config']['ambari.properties']['api.ssl'] == 'false'
    code "curl -k -X POST \
               -H 'X-Requested-By: ambari' \
               -u admin:admin http://#{ambari_server}:#{node['hw']['ambari']['server']['config']['ambari.properties']['client.api.port']}/api/v1/clusters/#{node['hw']['cluster']['name']} \
               -d @#{node['hw']['cluster']['hostmapping_file']}"
  else
    code "curl -k -X POST \
               -H 'X-Requested-By: ambari' \
               -u admin:admin https://#{ambari_server}:#{node['hw']['ambari']['server']['config']['ambari.properties']['client.api.ssl.port']}/api/v1/clusters/#{node['hw']['cluster']['name']} \
               -d @#{node['hw']['cluster']['hostmapping_file']}"
  end
  cwd '/var/lib/ambari-clusters'
  only_if { File.exist?("/var/lib/ambari-clusters/#{node['hw']['cluster']['hostmapping_file']}") }
end
