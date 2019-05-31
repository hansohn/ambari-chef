name 'ambari-chef'
maintainer 'Ryan Hansohn'
maintainer_email 'info@imnorobot.com'
license 'MIT'
description 'Installs/Configures ambari-chef'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.2'
chef_version '>= 12.14' if respond_to?(:chef_version)

supports 'centos', '>= 7.0'

depends 'hostsfile'
depends 'java-chef'
depends 'ulimit'

source_url 'https://github.com/hansohn/ambari-chef' if respond_to?(:source_url)
issues_url 'https://github.com/hansohn/ambari-chef/issues' if respond_to?(:issues_url)
