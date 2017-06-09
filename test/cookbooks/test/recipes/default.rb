#
# Cookbook:: bitbucket_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
bitbucket_install 'bitbucket' do
  jre_home "#{node['java']['java_home']}/jre"
  jvm_args node['bitbucket']['jvm_args']
end

bitbucket_config 'bitbucket' do
  bitbucket_properties node['bitbucket']['properties']
end

bitbucket_service 'bitbucket'
