default['bitbucket']['version']      = '5.0.1'
default['bitbucket']['product']      = 'bitbucket'
default['bitbucket']['home_path'] = "/var/atlassian/application-data/#{node['bitbucket']['product']}"
default['bitbucket']['install_path'] = '/opt/atlassian'
default['bitbucket']['install_type'] = 'standalone'
default['bitbucket']['service_type'] = 'init'
default['bitbucket']['url_base']     = "http://www.atlassian.com/software/stash/downloads/binary/atlassian-#{node['bitbucket']['product']}"
default['bitbucket']['user']         = 'atlbitbucket'
default['bitbucket']['url']      = "#{node['bitbucket']['url_base']}-#{node['bitbucket']['version']}.tar.gz"
default['bitbucket']['checksum'] =
  case node['bitbucket']['version']
  when '5.0.0' then '2731997d6e223cb512906183f5c231be602319ce05d2794cdf5b957a1fd06e08'
  when '5.0.1' then '2731997d6e223cb512906183f5c231be602319ce05d2794cdf5b957a1fd06e08'
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
