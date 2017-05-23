#
# Cookbook:: bitbucket_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
bitbucket_install 'bitbucket' do
  jre_home "#{node['java']['java_home']}/jre"
end
