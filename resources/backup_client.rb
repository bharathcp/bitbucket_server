#
# Cookbook:: bitbucket_backup_client
# Resource:: install Backup Client
#
resource_name :backup_client

property :product, String, default: 'bitbucket'
property :version, String, default: '3.3.2'
property :bitbucket_user, String, default: 'atlbitbucket'
property :bitbucket_group, String, default: 'atlbitbucket'
property :home_path, String, default: '/var/atlassian/application-data/bitbucket'
property :install_path, String, default: '/opt/atlassian'
property :client_url, String, default: 'https://maven.atlassian.com/content/groups/public/com/atlassian/bitbucket/server/backup/bitbucket-backup-distribution'
property :bitbucket_url, String, default: 'http://127.0.0.1:8080'
property :backup_path, String, required: true
property :backup_user, String, default: 'atlbitbucket'
property :backup_password, String

action :install do
  validate_version

  # Needed to install platform specific packages needed for ark
  include_recipe 'ark'

  ark "#{new_resource.product}-backup-client" do
    url "#{new_resource.client_url}/#{new_resource.version}/bitbucket-backup-distribution-#{new_resource.version}.zip"
    prefix_root new_resource.install_path
    prefix_home new_resource.install_path
    version new_resource.version
    owner new_resource.bitbucket_user
    group new_resource.bitbucket_group
  end

  template "#{new_resource.install_path}/#{new_resource.product}-backup-client/backup-config.properties" do
    source 'backup-config.properties.erb'
    owner new_resource.bitbucket_user
    mode 00755
    variables backup_client: {
      'user' => new_resource.backup_user,
      'password' => new_resource.backup_password,
      'base_url' => new_resource.bitbucket_url,
      'home_path' => new_resource.home_path,
      'backup_path' => new_resource.backup_path,
    }
    cookbook 'bitbucket_server'
  end

  link "#{new_resource.home_path}/shared/backup-config.properties" do
    to "#{new_resource.install_path}/#{new_resource.product}-backup-client/backup-config.properties"
  end
end

action_class do
  include ::BitbucketServer::Helpers
end
