#
# Cookbook Name:: ambari-chef
# Recipe:: repo_ambari
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# reload internal Chef yum cache
ruby_block 'yum_cache_reload' do
  block { Chef::Provider::Package::Yum::YumCache.instance.reload }
  action :nothing
end

# add ambari yum repo
remote_file 'ambari_yum_repo' do
  source node['hw']['ambari']['repo']
  path "/etc/yum.repos.d/ambari_#{node['hw']['ambari']['version']}.repo"
  owner 'root'
  group 'root'
  mode '0644'
  action :create_if_missing
  notifies :run, 'ruby_block[yum_cache_reload]', :immediately
end
