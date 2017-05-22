# # encoding: utf-8

# Inspec test for recipe bitbucket_server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('which java') do
  its('exit_status') { should eq 0 }
end

describe command('java -version') do
  its('stderr') { should include '1.8' }
end

control 'check-perl' do
  title 'Check perl compiled options and version'
  perl_out = command('perl -V')
  perl_ver = command('perl -e "print $]"')
  describe perl_out do
    its('exit_status') { should eq 0 }
    its('stdout') { should match (/USE_64_BIT_ALL/) }
    its('stdout') { should match (/useposix=true/) }
    its('stdout') { should match (/-fstack-protector/) }
  end
  get_perl_ver = perl_ver.stdout.to_f
  describe get_perl_ver do
    it { should be > 5.010 }
  end 
end

describe package('perl') do
  it { should be_installed }
  its('version') { should include '5.16' }
end

describe file('/usr/local/bin/git') do
  it { should be_executable }
end

describe command('/usr/local/bin/git --version') do
  its('stdout') { should include 'git version 2.8.1' }
end

describe file('/var/atlassian/application-data/bitbucket/shared/bitbucket.properties') do
  it { should exist }
  its('user') { should eq 'atlbitbucket' }
  its('content') { should include 'setup.displayName' }
end

unless os.windows?
  describe user('root') do
    it { should exist }
  end
  describe user('atlbitbucket') do
    it { should exist }
  end
  describe service('bitbucket') do
    it { should be_installed}
    it { should be_enabled}
    it { should be_running}
  end
end

describe port(7990) do
  it { should be_listening }
  its('protocols') { should include 'tcp6' }
  its('processes') {should include 'java'}
end

describe port(7992) do
  it { should be_listening }
  its('processes') { should include 'java' }
  its('protocols') { should include 'tcp6' }
end

describe port(7999) do
  it { should be_listening }
  its('processes') { should include 'java' }
  its('protocols') { should include 'tcp6' }
end
