#
# Cookbook Name:: ambari-chef
# Recipe:: ambari_agent
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# install ambari-agent
include_recipe "#{cookbook_name}::repo_ambari"
include_recipe "#{cookbook_name}::ambari_agent_install"
include_recipe "#{cookbook_name}::ambari_agent_user"
include_recipe "#{cookbook_name}::ambari_agent_config"
include_recipe "#{cookbook_name}::ambari_agent_service"

# install ambari agent applications
include_recipe "#{cookbook_name}::ambari_infra"
include_recipe "#{cookbook_name}::logsearch"
