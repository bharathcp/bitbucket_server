#
# Cookbook:: bitbucket_server
# Resource:: install
#
resource_name :bitbucket_server
property :server_name, String, name_property: true
property :version, String, default: '5.0.1'
property :product, String, default: 'bitbucket'
property :install_path, String, default: '/opt/atlassian' 
property :home_path, String, default: '/var/atlassian/application-data/bitbucket'
property :bin_path, String, default: '/opt/atlassian/bitbucket/bin'
property :install_type, String, default: 'standalone' # would prefer to call this server type
property :checksum, String, default: '677528dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad'
property :service_type, String, default: 'init'
property :url_base, String, default: 'http://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket'
# write a method to get full url and for bin path & ssh host name
property :bitbucket_user, String, default: 'atlbitbucket'
property :bitbucket_group, String, default: 'atlbitbucket'
property :database_type, String, default: 'postgresql'
property :database_version, String, default: '' 
property :database_host, String, default: '127.0.0.1'
property :database_name, String, default: 'bitbucket'
property :database_password, String, default: 'bitbucket'
property :database_testInterval, String, default: '2'
property :database_user, String, default: 'bitbucket'
property :database_port, String, default: ''
property :jvm_minimum_memory , String, default: '512m'
property :jvm_maximum_memory , String, default: '768m'
property :jvm_maximum_permgen, String, default: '384m'
property :jvm_java_opts, String, default: ''
property :jvm_support_args, String, default: ''
#property :ssh_hostname, String, default: '
property :ssh_port, String, default: '7999'
property :tomcat_port, String, default: '7990'
property :tomcat_session_timeout, String, default: '30'


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

  test_exit

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
  
  def test_exit
     Chef::Log.fatal("exit !!")
  end
end

