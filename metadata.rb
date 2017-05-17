name 'bitbucket_server'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures bitbucket_server'
long_description 'Installs/Configures bitbucket_server'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'java', '~> 1.49.0'
depends 'git', '~> 6.0.0'
depends 'ark', '~> 3.1.0'
