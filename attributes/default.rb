default['bitbucket']['version']      = '5.0.1'
default['bitbucket']['product']      = 'bitbucket'
default['bitbucket']['home_path'] = "/var/atlassian/application-data/#{node['bitbucket']['product']}"
default['bitbucket']['install_path'] = '/opt/atlassian'
default['bitbucket']['bin_path'] = "#{node['bitbucket']['install_path']}/#{node['bitbucket']['product']}/bin"
default['bitbucket']['install_type'] = 'standalone'
default['bitbucket']['service_type'] = 'init'
default['bitbucket']['url_base']     = "http://www.atlassian.com/software/stash/downloads/binary/atlassian-#{node['bitbucket']['product']}"
default['bitbucket']['user']         = 'atlbitbucket'
default['bitbucket']['url']      = "#{node['bitbucket']['url_base']}-#{node['bitbucket']['version']}.tar.gz"
default['bitbucket']['checksum'] =
  case node['bitbucket']['version']
  when '5.0.0' then 'a1505e06dc126279c710ce6c289fc41b078bab5de0beff44fc27bd17339ebdf9'
  when '5.0.1' then '677528dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad'
  end

default['bitbucket']['database']['type']     = 'postgresql'
# When not set, the defaults from postgresql cookbook are used.
# See: https://github.com/hw-cookbooks/postgresql/blob/v3.4.24/attributes/default.rb#L71-L228
default['bitbucket']['database']['version']  = nil

default['bitbucket']['database']['host'] = '127.0.0.1'
default['bitbucket']['database']['name'] = node['bitbucket']['product']
default['bitbucket']['database']['password'] = 'changeit'
default['bitbucket']['database']['testInterval'] = 2
default['bitbucket']['database']['user'] = node['bitbucket']['product']
default['bitbucket']['database']['port'] = nil

default['bitbucket']['jvm']['minimum_memory']  = '512m'
default['bitbucket']['jvm']['maximum_memory']  = '768m'
default['bitbucket']['jvm']['maximum_permgen'] = '384m'
default['bitbucket']['jvm']['java_opts']       = ''
default['bitbucket']['jvm']['support_args']    = ''

default['bitbucket']['ssh']['hostname'] = node['fqdn']
default['bitbucket']['ssh']['port']     = '7999'

default['bitbucket']['tomcat']['port'] = '7990'
default['bitbucket']['tomcat']['session-timeout'] = '30'

#default git
default['git']['version'] = '2.8.1'

#default java
default['java']['jdk_version'] = '8'
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true
