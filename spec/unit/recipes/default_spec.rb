#
# Cookbook:: bitbucket_server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bitbucket_server::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'should include necessary recipes' do
      expect(chef_run).to include_recipe('bitbucket_server::linux_standalone')
      expect(chef_run).to include_recipe('bitbucket_server::configuration')
      expect(chef_run).to include_recipe('bitbucket_server::service_init')
    end
  end
end
