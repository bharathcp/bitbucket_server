#
# Cookbook:: bitbucket_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

bitbucket_server_install 'bitbucket' do
  jre_home "#{node['java']['java_home']}/jre"
end

bitbucket_server_configure 'bitbucket' do
  bitbucket_properties node['bitbucket']['properties']
end

bitbucket_server_service 'bitbucket'
