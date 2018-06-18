#
# Cookbook Name:: ambari-chef
# Recipe:: hw_cluster
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

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
