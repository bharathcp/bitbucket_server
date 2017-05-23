#
# Cookbook:: bitbucket_server
# Spec:: service_init_spec
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bitbucket_server::service_init' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }
  it 'creates a bitbucket systemd unit with an explicit action' do
    expect(chef_run).to create_systemd_unit('bitbucket.service')
    expect(chef_run).to enable_systemd_unit('bitbucket.service')
    expect(chef_run).to enable_service('bitbucket')
  end
end
