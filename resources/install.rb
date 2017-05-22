#
# Cookbook:: bitbucket_server
# Resource:: install
#
property :product, String, default: node['bitbucket']['product']
property :version, String, default: node['bitbucket']['version']
property :bitbucket_user, String, default: node['bitbucket']['user']
property :bitbucket_group, String, default: node['bitbucket']['group']
property :home_path, String, default: node['bitbucket']['home_path']
property :install_path, String, default: node['bitbucket']['install_path']
property :checksum, String, default: '677528dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad'
property :url_base, String, default: node['bitbucket']['url_base']

action :install do
  validate_version

  directory new_resource.home_path do
    owner 'root'
    group 'root'
    mode 00755
    action :create
    recursive true
  end

  group new_resource.bitbucket_group do
    action :create
    append true
  end

  user new_resource.bitbucket_user do
    gid new_resource.bitbucket_group
    comment 'Bitbucket Service Account'
    home new_resource.home_path
    shell '/bin/bash'
    manage_home true
    system true
    action :create
  end

  # changing ownership after user creation
  directory new_resource.home_path do
    owner new_resource.bitbucket_user 
    group new_resource.bitbucket_group 
    mode 00755
    action :create
    recursive true
  end

  directory new_resource.install_path do
    owner new_resource.bitbucket_user 
    group new_resource.bitbucket_group 
    mode 00755
    action :create
    recursive true
  end

  ark new_resource.product do
    url get_pkg_url
    prefix_root new_resource.install_path
    prefix_home new_resource.install_path
    checksum new_resource.checksum
    version new_resource.version
    owner new_resource.bitbucket_user
    group new_resource.bitbucket_group
  end

end

action_class.class_eval do
  # ensure version in semver format MAJOR.MINOR.PATCH  
  def validate_version
    return if new_resource.version =~ /\d+.\d+.\d+/
    Chef::Log.fatal("The version must be in MAJOR.MINOR.PATCH format. Passed value: #{new_resource.version}")
    raise
  end

  def get_pkg_url
     return "#{new_resource.url_base}-#{new_resource.version}.tar.gz" 
  end
  
end

