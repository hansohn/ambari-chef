#
# Cookbook:: ambari-chef
# Recipe:: python2
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# python2 upgrade pips
bash 'python2_upgrade_pips' do
  code 'python2 -m pip install --upgrade pip setuptools wheel'
  action :nothing
end

# python2 install packages
package 'python2_install' do
  package_name node['python']['python2']['packages']
  action :install
  notifies :run, 'bash[python2_upgrade_pips]', :immediately
end

# python2 install pips
if node['python']['python2']['pips'].any?
  node['python']['python2']['pips'].each do |pip|
    bash "python2_install_pip_#{pip}" do
      code "python2 -m pip install '#{pip}'"
      action :run
    end
  end
end
