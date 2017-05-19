#
# Cookbook:: bitbucket_server
# Spec:: configuration_spec
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bitbucket_server::configuration' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.default['bitbucket']['properties'] = {"setup.displayName": "EPLBitbucket", "setup.baseUrl": "localhost:7990"}
      end
      runner.converge('bitbucket_server::service_init',described_recipe)
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'creates shared dir in bitbucket home' do
      path = '/var/atlassian/application-data/bitbucket/shared'
      expect(chef_run).to create_directory(path).with(
        user: 'atlbitbucket',
        group: 'atlbitbucket',
        mode: 00755
      )
    end
    it 'creates bitbucket.properties in BITBUCKET_HOME/shared' do
      path = '/var/atlassian/application-data/bitbucket/shared/bitbucket.properties'
      expect(chef_run).to create_template(path).with(
        user: 'atlbitbucket',
        group: 'atlbitbucket',
        mode: 00644
      )
      expect(chef_run).to render_file(path).with_content{|content|
        expect(content).to include('setup.displayName=EPLBitbucket')
        expect(content).to include('setup.baseUrl=localhost:7990')
      }
      expect(chef_run.template(path)).to notify('service[bitbucket]').delayed
    end
  end
end
