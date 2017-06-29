#
# Cookbook:: bitbucket_server
# Spec:: specific_version
#
# Copyright:: 2017, The Authors, All Rights Reserved.
require 'spec_helper'

describe 'test::specific_version' do
  context 'Step into install resources and test invalid version=nil' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'bitbucket_install', platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        node.default['bitbucket']['version'] = nil
        server.update_node(node)
      end.converge(described_recipe)
    end
    it 'raises a validation error' do
      expect { chef_run }.to raise_error.with_message(/Property version must be one of: String!  You passed nil./)
    end
  end

  context 'Step into install resources and test invalid version=5' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'bitbucket_install', platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        node.default['bitbucket']['version'] = '5'
        server.update_node(node)
      end.converge(described_recipe)
    end
    it 'raises a validation error' do
      expect { chef_run }.to raise_error(RuntimeError, /The version must be in MAJOR.MINOR.PATCH format. Passed value: 5/)
    end
  end

  context 'Step into install resources and test invalid version=5.0' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'bitbucket_install', platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        node.default['bitbucket']['version'] = '5.0'
        server.update_node(node)
      end.converge(described_recipe)
    end
    it 'raises a validation error' do
      expect { chef_run }.to raise_error(RuntimeError, /The version must be in MAJOR.MINOR.PATCH format. Passed value: 5.0/)
    end
  end

  context 'Step into install resources and test invalid version=5.0' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'bitbucket_install', platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        node.default['bitbucket']['version'] = '5.0'
        server.update_node(node)
      end.converge(described_recipe)
    end
    it 'raises a validation error' do
      expect { chef_run }.to raise_error(RuntimeError, /The version must be in MAJOR.MINOR.PATCH format. Passed value: 5.0/)
    end
  end

  context 'Step into install resources and test version=6.0.3 that does not have a default checksum defined in cookbook' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'bitbucket_install', platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        node.default['bitbucket']['version'] = '6.0.3'
        server.update_node(node)
      end.converge(described_recipe)
    end
    it 'raises a validation error' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'Step into install resources and test valid version=5.0.1' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'bitbucket_install', platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        node.default['bitbucket']['version'] = '5.0.1'
        server.update_node(node)
      end.converge(described_recipe)
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'calculates an appropriate checksum' do
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
  context 'Step into install resources and test valid version=5.0.1 and override checksum' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'bitbucket_install', platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        node.default['bitbucket']['version'] = '5.0.1'
        node.default['bitbucket']['checksum'] = 'test28dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad'
        server.update_node(node)
      end.converge(described_recipe)
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'uses the checksum that is passed' do
      expect(chef_run).to install_ark('bitbucket')
        .with_url('http://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-5.0.1.tar.gz')
        .with_prefix_root('/opt/atlassian')
        .with_prefix_home('/opt/atlassian')
        .with_checksum('test28dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad')
        .with_version('5.0.1')
        .with_owner('atlbitbucket')
        .with_group('atlbitbucket')
    end
  end
end
