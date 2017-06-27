#
# Cookbook:: bitbucket_server
# Spec:: specific_version
#
# Copyright:: 2017, The Authors, All Rights Reserved.
require 'spec_helper'

describe 'test::backup_client' do
  context 'Step into backup client install resources' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'backup_client', platform: 'centos', version: '7.3.1611') do |node, server|
        server.update_node(node)
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs bitbucket backup client' do
      expect(chef_run).to backup_client('bitbucket')
    end

    it 'ark installs bitbucket-backup-client package' do
      expect(chef_run).to install_ark('bitbucket-backup-client')
        .with_url('https://maven.atlassian.com/content/groups/public/com/atlassian/bitbucket/server/backup/bitbucket-backup-distribution/3.3.2/bitbucket-backup-distribution-3.3.2.zip')
        .with_prefix_root('/opt/atlassian')
        .with_prefix_home('/opt/atlassian')
        .with_version('3.3.2')
        .with_owner('atlbitbucket')
        .with_group('atlbitbucket')
    end

    it 'configures backup-config.properties' do
      expect(chef_run).to create_template('/opt/atlassian/bitbucket-backup-client/backup-config.properties')
        .with_source('backup-config.properties.erb')
        .with_owner('atlbitbucket')
        .with_variables(backup_client: { 'user' => 'bitbucket_backup', 'password' => 'bitbucket_admin', 'base_url' => 'http://localhost:7990', 'home_path' => '/var/atlassian/application-data/bitbucket', 'backup_path' => '/tmp' })
        .with_cookbook('bitbucket_server')
    end

    it 'configures symlink for backup-config.properties from home path to install path' do
      expect(chef_run).to create_link('/var/atlassian/application-data/bitbucket/shared/backup-config.properties')
        .with_to('/opt/atlassian/bitbucket-backup-client/backup-config.properties')
    end
  end
end
