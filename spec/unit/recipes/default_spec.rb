#
# Cookbook:: bitbucket_server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bitbucket_server::default' do
  context 'Without stepping into custom resources and default values' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611') do |node, server|
        node.set['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.set['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        server.update_node(node)
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
      expect(chef_run).to install_bitbucket('bitbucket')
        .with_jre_home('/usr/lib/jvm/java-8-oracl/jre')
      expect(chef_run).to config_bitbucket('bitbucket')
        .with_bitbucket_properties('setup.displayName' => 'my bitbucket')
      expect(chef_run).to service_bitbucket('bitbucket')
    end
  end
  context 'Step into custom resources and default values' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: ['bitbucket_install','bitbucket_config','bitbucket_service'], platform: 'centos', version: '7.3.1611') do |node, server|
        node.set['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.set['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        server.update_node(node)
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
      expect(chef_run).to install_bitbucket('bitbucket')
        .with_jre_home('/usr/lib/jvm/java-8-oracl/jre')
      expect(chef_run).to config_bitbucket('bitbucket')
        .with_bitbucket_properties('setup.displayName' => 'my bitbucket')
      expect(chef_run).to service_bitbucket('bitbucket')
    end

    it 'installs bitbucket' do
      expect(chef_run).to create_directory('/var/atlassian/application-data/bitbucket')
        .with_user('atlbitbucket').with_mode(00755)
      expect(chef_run).to create_group('atlbitbucket').with_append(true)
      expect(chef_run).to create_user('atlbitbucket')
        .with_gid('atlbitbucket').with_home('/var/atlassian/application-data/bitbucket')
        .with_shell('/bin/bash').with_manage_home(true).with_system(true)
      expect(chef_run).to create_directory('/opt/atlassian')
        .with_user('atlbitbucket').with_mode(00755)
      expect(chef_run).to install_ark('bitbucket')
        .with_url('http://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-5.0.1.tar.gz')
        .with_prefix_root('/opt/atlassian')
        .with_prefix_home('/opt/atlassian')
        .with_checksum('677528dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad')
        .with_version('5.0.1')
        .with_owner('atlbitbucket')
        .with_group('atlbitbucket')

    end

  end
end
