name 'bitbucket_server'
maintainer 'Bharath, Raghavendra Gona'
maintainer_email 'cippy.bharath@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures bitbucket_server'
long_description 'Installs/Configures bitbucket_server'
version '0.1.8'
chef_version '>= 12.7' if respond_to?(:chef_version)

issues_url 'https://github.com/bharathcp/bitbucket_server/issues' if respond_to?(:issues_url)
source_url 'https://github.com/bharathcp/bitbucket_server' if respond_to?(:source_url)

supports 'centos', '>= 7.3'
supports 'ubuntu', '>= 16.04'
supports 'debian', '>= 8.8'
supports 'fedora', '>= 25'
supports 'opensuse', '>= 42.2'

depends 'ark', '~> 3.1.0'
