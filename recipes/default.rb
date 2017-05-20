#
# Cookbook:: bitbucket_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

bitbucket_server_install 'altbitbucket' do
  bitbucket_user 'altbit'
  bitbucket_group 'altbit'
end

#include_recipe 'bitbucket_server::linux_standalone'
#include_recipe 'bitbucket_server::configuration'
#include_recipe 'bitbucket_server::service_init'
