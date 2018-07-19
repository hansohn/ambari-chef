#
# Cookbook:: ambari-chef
# Recipe:: ambari_server_prerequisites
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# install prerequsites
include_recipe "#{cookbook_name}::config_disable_ipv6"
include_recipe "#{cookbook_name}::config_update_hostfile"
include_recipe "#{cookbook_name}::python2"
include_recipe 'java-chef::install'
include_recipe "#{cookbook_name}::postgres_install"
