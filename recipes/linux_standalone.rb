# frozen_string_literal: true

directory File.dirname(node['bitbucket']['home_path']) do
  owner node['bitbucket']['user']
  group node['bitbucket']['user']
  mode 00755
  action :create
  recursive true
end

user node['bitbucket']['user'] do
  comment 'bitbucket Service Account'
  home node['bitbucket']['home_path']
  shell '/bin/bash'
  manage_home true
  system true
  action :create
end

directory node['bitbucket']['install_path'] do
  owner node['bitbucket']['user']
  group node['bitbucket']['user']
  mode 00755
  action :create
  recursive true
end

ark node['bitbucket']['product'] do
  url node['bitbucket']['url']
  prefix_root node['bitbucket']['install_path']
  prefix_home node['bitbucket']['install_path']
  checksum node['bitbucket']['checksum']
  version node['bitbucket']['version']
  owner node['bitbucket']['user']
  group node['bitbucket']['user']
end
