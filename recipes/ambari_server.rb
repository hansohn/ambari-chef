#
# Cookbook Name:: ambari-chef
# Recipe:: ambari_server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


# install ambari-server
include_recipe "#{cookbook_name}::repo_ambari"
include_recipe "#{cookbook_name}::ambari_server_install"
include_recipe "#{cookbook_name}::ambari_server_user"
include_recipe "#{cookbook_name}::ambari_server_config"
include_recipe "#{cookbook_name}::ambari_server_service"
include_recipe "#{cookbook_name}::ambari_agent_install"
include_recipe "#{cookbook_name}::ambari_agent_user"
include_recipe "#{cookbook_name}::ambari_agent_config"
include_recipe "#{cookbook_name}::ambari_agent_service"
