# # encoding: utf-8

# Inspec test for recipe bitbucket_server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('which java ') do
  it { should exist }
  its('exit_status') { should eq 0 }
end

describe command('java -version') do
  its('stderr') { should be > 1.8 }
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

describe command('which git ') do
  it { should exist }
  its('exit_status') { should eq 0 }
end

describe command('git -version') do
  its('stderr') { should be > 1.8 }
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end
