#
# Cookbook:: ambari-chef
# Recipe:: ambari_agent_prerequisites
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# install prerequsites
include_recipe "#{cookbook_name}::config_disable_ipv6"
include_recipe 'java-chef::install'
