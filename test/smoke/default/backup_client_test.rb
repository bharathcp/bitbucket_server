# # encoding: utf-8

# Inspec test for recipe bitbucket_server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/var/atlassian/application-data/bitbucket/shared/backup-config.properties') do
  it { should exist }
  it { should be_owned_by 'atlbitbucket' }
  it { should be_grouped_into 'atlbitbucket' }
  its('mode') { should cmp '0755' }
  its('content') { should include 'bitbucket.baseUrl' }
end

jars = ['bitbucket-backup-client.jar','bitbucket-restore-client.jar']

jars.each do | jar |
  describe file("/opt/atlassian/bitbucket-backup-client/#{jar}") do
    it { should exist }
    it { should be_readable }
    it { should be_readable.by_user('atlbitbucket') }
  end
end

