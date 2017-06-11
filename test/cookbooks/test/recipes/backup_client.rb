#
# Cookbook:: bitbucket_server
# Recipe:: Install Backup Client
#
# Copyright:: 2017, The Authors, All Rights Reserved.
package 'unzip'

install_backup_client 'bitbucket' do
  backup_user 'bitbucket_backup'
  backup_password 'bitbucket_admin'
  bitbucket_url 'http://localhost:7990'
  backup_path '/tmp'
end

