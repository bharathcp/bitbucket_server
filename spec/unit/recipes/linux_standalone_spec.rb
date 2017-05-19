#
# Cookbook:: bitbucket_server
# Spec:: linux_standalone_spec
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bitbucket_server::linux_standalone' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge('bitbucket_server::service_init',described_recipe)
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'creates bitbucket home' do
      path = '/var/atlassian/application-data'
      expect(chef_run).to create_directory(path).with(
        user: 'atlbitbucket',
        group: 'atlbitbucket',
        mode: 00755
      )
    end
    it 'creates install path' do
      path = '/opt/atlassian'
      expect(chef_run).to create_directory(path).with(
        user: 'atlbitbucket',
        group: 'atlbitbucket',
        mode: 00755
      )
    end
    it 'generates script to set BITBUCKET_HOME' do
      path = '/opt/atlassian/bitbucket/bin/set-bitbucket-home.sh'
      expect(chef_run).to create_template(path).with(
        user: 'atlbitbucket',
        group: 'atlbitbucket',
        mode: 00755
      )
      expect(chef_run.template(path)).to notify('service[bitbucket]').delayed
    end
    it 'creates service account' do
      path = '/var/atlassian/application-data/bitbucket'
      user = 'atlbitbucket'
      expect(chef_run).to create_user(user).with(
        home: path,
        shell: '/bin/bash',
        system: true
      )
    end
    it 'installs bitbucket' do
      path = '/var/atlassian/application-data/bitbucket'
      user = 'atlbitbucket'
      expect(chef_run).to install_ark 'bitbucket'
    end
  end
end
