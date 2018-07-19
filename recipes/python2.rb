#
# Cookbook:: ambari-chef
# Recipe:: python2
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

# python2 upgrade pips
bash 'python2_upgrade_pips' do
  code 'python2 -m pip install --upgrade pip setuptools wheel'
  action :nothing
end

# python2 install packages
if node['python']['python2']['install']
  package 'python2_install' do
    package_name node['python']['python2']['packages']
    action :install
    notifies :run, 'bash[python2_upgrade_pips]', :immediately
  end
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
