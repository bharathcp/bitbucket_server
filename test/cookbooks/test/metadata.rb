name 'test'
maintainer 'Bharath, Raghavendra Gona'
maintainer_email 'cippy.bharath@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures bitbucket_server'
long_description 'Installs/Configures bitbucket_server'
version '1.0.0'
chef_version '>= 12.4' if respond_to?(:chef_version)

supports 'centos', '>= 7.3'

depends 'java'
depends 'git'
depends 'bitbucket_server'
