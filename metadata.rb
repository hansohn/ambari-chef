name 'ambari-chef'
maintainer 'Ryan Hansohn'
maintainer_email 'info@imnorobot.com'
license 'MIT'
description 'Installs/Configures ambari-chef'
version '1.1.0'
chef_version '>= 12.14'

supports 'centos', '>= 7.0'

depends 'hostsfile'
depends 'java-chef'
depends 'ulimit'

source_url 'https://github.com/hansohn/ambari-chef'
issues_url 'https://github.com/hansohn/ambari-chef/issues'
