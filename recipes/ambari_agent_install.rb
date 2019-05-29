#
# Cookbook Name:: ambari-chef
# Recipe:: ambari_agent_install
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

ambari_version = -> { node['hw']['ambari']['version'] }
ambari_version_full = -> { node['hw']['ambari'][ambari_version.call]['version_full'] }

# include package(s)
package ['openssl-devel', 'python']

# install ambari-server
package 'ambari-agent' do
  package_name 'ambari-agent'
  version ambari_version_full.call
  action :install
  not_if { ::File.exist?('/etc/rc.d/init.d/ambari-agent') }
end
