# # encoding: utf-8

# Inspec test for recipe bitbucket_server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/var/atlassian/application-data/bitbucket/shared/backup-config.properties') do
  it { should exist }
end

describe file('/opt/atlassian/bitbucket-backup-client/bitbucket-backup-client.jar') do
  it { should exist }
end

describe file('/opt/atlassian/bitbucket-backup-client/bitbucket-restore-client.jar') do
  it { should exist }
end
