#
# Cookbook:: bitbucket_server
# Spec:: specific_version
#
# Copyright:: 2017, The Authors, All Rights Reserved.

describe 'test::specific_params' do
  context 'install configure and service bitbucket with specific params' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['jvm_args'] = 'jvmargs'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        server.update_node(node)
      end.converge(described_recipe)
    end
    it 'raises a validation error' do
      expect { chef_run }.to_not raise_error
    end
    it 'installs bitbucket server with all the params' do
      expect(chef_run).to install_bitbucket('bitbucket')
        .with_jre_home('/usr/lib/jvm/java-8-oracl/jre')
        .with_product('stash')
        .with_version('5.1.0')
        .with_bitbucket_user('bitbucket')
        .with_bitbucket_group('bitbucket')
        .with_home_path('/homepath')
        .with_install_path('/installpath')
        .with_checksum('8bfefd43dae2aaab7193f569e6a15ac3c9bc9aeb8922f4bf299c0984c66f7907')
        .with_url_base('customurl')
        .with_jre_home('/usr/lib/jvm/java-8-oracl/jre')
        .with_jvm_args('jvmargs')
    end
    it 'configures bitbucket server with all the params' do
      expect(chef_run).to config_bitbucket('bitbucket')
        .with_product('stash')
        .with_bitbucket_user('bitbucket')
        .with_bitbucket_group('bitbucket')
        .with_home_path('/homepath')
        .with_bitbucket_properties('setup.displayName' => 'my bitbucket')
    end
    it 'configures bitbucket service' do
      expect(chef_run).to service_bitbucket('bitbucket')
        .with_product('stash')
        .with_bitbucket_user('bitbucket')
        .with_install_path('/installpath')
    end
  end
  context 'step into and test install configure and service bitbucket with specific params' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: %w(bitbucket_install bitbucket_config bitbucket_service), platform: 'centos', version: '7.3.1611') do |node, server|
        node.default['java']['java_home'] = '/usr/lib/jvm/java-8-oracl'
        node.default['bitbucket']['jvm_args'] = 'jvmargs'
        node.default['bitbucket']['properties'] = { 'setup.displayName' => 'my bitbucket' }
        server.update_node(node)
      end.converge(described_recipe)
    end

    it 'raises a validation error' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates bitbucket home directory' do
      expect(chef_run).to create_directory('/homepath')
        .with_user('bitbucket').with_mode(00755)
    end

    it 'creates bitbucket group' do
      expect(chef_run).to create_group('bitbucket').with_append(true)
    end

    it 'creates bitbucket user' do
      expect(chef_run).to create_user('bitbucket')
        .with_gid('bitbucket').with_home('/homepath')
        .with_shell('/bin/bash').with_manage_home(true).with_system(true)
    end

    it 'creates bitbucket install directory' do
      expect(chef_run).to create_directory('/installpath')
        .with_user('bitbucket').with_mode(00755)
    end

    it 'ark installs bitbucket package' do
      expect(chef_run).to install_ark('stash')
        .with_url('customurl-5.1.0.tar.gz')
        .with_prefix_root('/installpath')
        .with_prefix_home('/installpath')
        .with_checksum('8bfefd43dae2aaab7193f569e6a15ac3c9bc9aeb8922f4bf299c0984c66f7907')
        .with_version('5.1.0')
        .with_owner('bitbucket')
        .with_group('bitbucket')
    end

    it 'configures set-bitbucket-home.sh and restart bitbucket service' do
      expect(chef_run).to create_template('/installpath/bitbucket/bin/set-bitbucket-home.sh')
        .with_source('set-bitbucket-home.sh.erb')
        .with_owner('bitbucket')
        .with_group('bitbucket')
        .with_mode(00755)
        .with_variables(home_path: '/homepath')
        .with_cookbook('bitbucket_server')
      expect(chef_run.template('/installpath/bitbucket/bin/set-bitbucket-home.sh'))
        .to notify('service[stash]').to(:restart).delayed
    end

    it 'does not configure _start-webapp.sh' do
      expect(chef_run).to create_template('/installpath/bitbucket/bin/_start-webapp.sh')
    end

    it 'configures set-jre-home.sh and restart bitbucket service' do
      expect(chef_run).to create_template('/installpath/bitbucket/bin/set-jre-home.sh')
        .with_source('set-jre-home.sh.erb')
        .with_owner('bitbucket')
        .with_group('bitbucket')
        .with_mode(00755)
        .with_variables(jre_home: '/usr/lib/jvm/java-8-oracl/jre')
        .with_cookbook('bitbucket_server')
      expect(chef_run.template('/installpath/bitbucket/bin/set-jre-home.sh'))
        .to notify('service[stash]').to(:restart).delayed
    end

    it 'does nothing to bitbucket service' do
      expect(chef_run.service('stash')).to do_nothing
    end

    it 'creates bitbucket shared directory inside bitbucket home' do
      expect(chef_run).to create_directory('/homepath/shared')
        .with_user('bitbucket').with_mode(00755)
    end

    it 'configures bitbucket.properties and restart bitbucket service' do
      expect(chef_run).to create_template('/homepath/shared/bitbucket.properties')
        .with_source('bitbucket.properties.erb')
        .with_owner('bitbucket')
        .with_group('bitbucket')
        .with_mode(00644)
        .with_variables(properties: { 'setup.displayName' => 'my bitbucket' })
        .with_cookbook('bitbucket_server')
      expect(chef_run.template('/homepath/shared/bitbucket.properties'))
        .to notify('service[stash]').to(:restart).delayed
    end
  end
end
