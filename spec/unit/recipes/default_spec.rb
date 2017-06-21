#
# Cookbook:: bitbucket_server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

describe 'test::default' do
  context 'Without stepping into custom resources and default values' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        server.update_node(node)
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs bitbucket server' do
      expect(chef_run).to install_bitbucket('bitbucket')
        .with_jre_home('/usr/lib/jvm/java-8-oracl/jre')
    end

    it 'configures bitbucket server' do
      expect(chef_run).to config_bitbucket('bitbucket')
        .with_bitbucket_properties('setup.displayName' => 'my bitbucket')
    end

    it 'creates a bitbucket service' do
      expect(chef_run).to service_bitbucket('bitbucket')
    end
  end

  context 'Step into custom resources and default values' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: %w(bitbucket_install bitbucket_config bitbucket_service), platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
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

    it 'creates bitbucket home directory' do
      expect(chef_run).to create_directory('/var/atlassian/application-data/bitbucket')
        .with_user('atlbitbucket').with_mode(00755)
    end

    it 'creates atlbitbucket group' do
      expect(chef_run).to create_group('atlbitbucket').with_append(true)
    end

    it 'creates atlbitbucket user' do
      expect(chef_run).to create_user('atlbitbucket')
        .with_gid('atlbitbucket').with_home('/var/atlassian/application-data/bitbucket')
        .with_shell('/bin/bash').with_manage_home(true).with_system(true)
    end

    it 'creates bitbucket install directory' do
      expect(chef_run).to create_directory('/opt/atlassian')
        .with_user('atlbitbucket').with_mode(00755)
    end

    it 'ark installs bitbucket package' do
      expect(chef_run).to install_ark('bitbucket')
        .with_url('http://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-5.0.1.tar.gz')
        .with_prefix_root('/opt/atlassian')
        .with_prefix_home('/opt/atlassian')
        .with_checksum('677528dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad')
        .with_version('5.0.1')
        .with_owner('atlbitbucket')
        .with_group('atlbitbucket')
    end

    it 'configures set-bitbucket-home.sh and restart bitbucket service' do
      expect(chef_run).to create_template('/opt/atlassian/bitbucket/bin/set-bitbucket-home.sh')
        .with_source('set-bitbucket-home.sh.erb')
        .with_owner('atlbitbucket')
        .with_group('atlbitbucket')
        .with_mode(00755)
        .with_variables(home_path: '/var/atlassian/application-data/bitbucket')
        .with_cookbook('bitbucket_server')
      expect(chef_run.template('/opt/atlassian/bitbucket/bin/set-bitbucket-home.sh'))
        .to notify('service[bitbucket]').to(:restart).delayed
    end

    it 'does not configure _start-webapp.sh' do
      expect(chef_run).to_not create_template('/opt/atlassian/bitbucket/bin/_start-webapp.sh')
    end

    it 'configures set-jre-home.sh and restart bitbucket service' do
      expect(chef_run).to create_template('/opt/atlassian/bitbucket/bin/set-jre-home.sh')
        .with_source('set-jre-home.sh.erb')
        .with_owner('atlbitbucket')
        .with_group('atlbitbucket')
        .with_mode(00755)
        .with_variables(jre_home: '/usr/lib/jvm/java-8-oracl/jre')
        .with_cookbook('bitbucket_server')
      expect(chef_run.template('/opt/atlassian/bitbucket/bin/set-jre-home.sh'))
        .to notify('service[bitbucket]').to(:restart).delayed
    end

    it 'does nothing to bitbucket service' do
      expect(chef_run.service('bitbucket')).to do_nothing
    end

    it 'creates bitbucket shared directory inside bitbucket home' do
      expect(chef_run).to create_directory('/var/atlassian/application-data/bitbucket/shared')
        .with_user('atlbitbucket').with_mode(00755)
    end

    it 'configures bitbucket.properties and restart bitbucket service' do
      expect(chef_run).to create_template('/var/atlassian/application-data/bitbucket/shared/bitbucket.properties')
        .with_source('bitbucket.properties.erb')
        .with_owner('atlbitbucket')
        .with_group('atlbitbucket')
        .with_mode(00644)
        .with_variables(properties: { 'setup.displayName' => 'my bitbucket' })
        .with_cookbook('bitbucket_server')
      expect(chef_run.template('/var/atlassian/application-data/bitbucket/shared/bitbucket.properties'))
        .to notify('service[bitbucket]').to(:restart).delayed
    end
  end

  context 'Step into custom resources with jvm_args defined' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: %w(bitbucket_install bitbucket_config bitbucket_service), platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        node.default['bitbucket']['jvm_args'] = '-Dhttp.proxy=blah'
        server.update_node(node)
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
      expect(chef_run).to install_bitbucket('bitbucket')
        .with_jre_home('/usr/lib/jvm/java-8-oracl/jre')
        .with_jvm_args('-Dhttp.proxy=blah')
      expect(chef_run).to config_bitbucket('bitbucket')
        .with_bitbucket_properties('setup.displayName' => 'my bitbucket')
      expect(chef_run).to service_bitbucket('bitbucket')
    end

    it 'configure _start-webapp.sh' do
      expect(chef_run).to create_template('/opt/atlassian/bitbucket/bin/_start-webapp.sh')
        .with_variables(jvm_args: '-Dhttp.proxy=blah')
    end
  end
end
