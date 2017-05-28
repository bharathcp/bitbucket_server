#
# Cookbook:: bitbucket_server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bitbucket_server::default' do
  context 'Without stepping into custom resources' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node, server|
        node.set['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.set['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        server.update_node(node)
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
      expect(chef_run).to install_bitbucket('bitbucket').with_jre_home('/usr/lib/jvm/java-8-oracl/jre')
      expect(chef_run).to config_bitbucket('bitbucket').with_bitbucket_properties('setup.displayName' => 'my bitbucket')
      expect(chef_run).to service_bitbucket('bitbucket')
    end
  end
end
