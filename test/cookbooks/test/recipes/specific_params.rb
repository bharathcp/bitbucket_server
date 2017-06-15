#
# Cookbook:: bitbucket_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
bitbucket_install 'bitbucket' do
  product 'stash'
  version '5.1.0'
  bitbucket_user 'bitbucket'
  bitbucket_group 'bitbucket'
  home_path '/homepath'
  install_path '/installpath'
  checksum '8bfefd43dae2aaab7193f569e6a15ac3c9bc9aeb8922f4bf299c0984c66f7907'
  url_base 'customurl'
  jre_home "#{node['java']['java_home']}/jre"
  jvm_args node['bitbucket']['jvm_args']
end

bitbucket_config 'bitbucket' do
  product 'stash'
  home_path '/homepath'
  bitbucket_user 'bitbucket'
  bitbucket_group 'bitbucket'
  bitbucket_properties node['bitbucket']['properties']
end

bitbucket_service 'bitbucket' do
  product 'stash'
  install_path '/installpath'
  bitbucket_user 'bitbucket'
end
