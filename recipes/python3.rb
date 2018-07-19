#
# Cookbook:: ambari-chef
# Recipe:: python3
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# python3 upgrade pips
bash 'python3_upgrade_pips' do
  code 'python3 -m pip install --upgrade pip setuptools wheel'
  action :nothing
end

# python3 install packages
if node['python']['python3']['install']
  package 'python3_install' do
    package_name node['python']['python3']['packages']
    action :install
    notifies :run, 'bash[python3_upgrade_pips]', :immediately
  end
end

# python3 install pips
if node['python']['python3']['pips'].any?
  node['python']['python3']['pips'].each do |pip|
    bash "python3_install_pip_#{pip}" do
      code "python3 -m pip install '#{pip}'"
      action :run
    end
  end
end
