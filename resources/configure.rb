#
# Cookbook:: bitbucket_server
# Resource:: configure
#
resource_name :bitbucket_config

property :product, String, default: 'bitbucket'
property :home_path, String, default: '/var/atlassian/application-data/bitbucket'
property :bitbucket_user, String, default: 'atlbitbucket'
property :bitbucket_group, String, default: 'atlbitbucket'
# Ideally `bitbucket_properties` should be madatory
# But `load_current_value` method will assign it to nil on the first run.
# This results in `Chef::Exceptions::ValidationFailed - "bitbucket_properties is required"`
property :bitbucket_properties, Hash

load_current_value do
  if ::File.exist?("#{home_path}/shared/bitbucket.properties") && ::File.exist?("#{home_path}/shared/bitbucket.properties.bak")
    properties = {}
    ::File.open("#{home_path}/shared/bitbucket.properties.bak", 'r') do |properties_file|
      properties_file.read.each_line do |line|
        line.strip!
        next unless (line[0] != '#') && (line[0] != '=')
        i = line.index('=')
        if i
          properties[line[0..i - 1].strip] = line[i + 1..-1].strip
        else
          properties[line] = ''
        end
      end
    end
    bitbucket_properties properties
  end
end

action :create do
  directory "#{new_resource.home_path}/shared" do
    owner new_resource.bitbucket_user
    group new_resource.bitbucket_group
    mode 00755
    action :create
    recursive true
    # notifies :restart, "service[#{new_resource.product}]", :delayed
  end

  template "#{new_resource.home_path}/shared/bitbucket.properties.bak" do
    source 'bitbucket.properties.erb'
    owner new_resource.bitbucket_user
    group new_resource.bitbucket_group
    mode 00644
    action :create
    variables(
      properties: new_resource.bitbucket_properties
    )
    cookbook 'bitbucket_server'
    only_if { ::File.exist?("#{new_resource.home_path}/shared/bitbucket.properties.bak") }
    # notifies :restart, "service[#{new_resource.product}]", :delayed
  end

  converge_if_changed do
    template "#{new_resource.home_path}/shared/bitbucket.properties" do
      source 'bitbucket.properties.erb'
      owner new_resource.bitbucket_user
      group new_resource.bitbucket_group
      mode 00644
      action :create
      variables(
        properties: new_resource.bitbucket_properties
      )
      cookbook 'bitbucket_server'
      notifies :restart, "service[#{new_resource.product}]", :delayed
    end

    # This is to ensure idempotence after the first setup. Bitbucket creates this
    # file after the first setup. Any change to the config after teh first setup
    # is not written into the .bak. Since cinverge_if_changed compares the .bak
    # using load_current_value, we will need to update this with changes if any.
    template "#{new_resource.home_path}/shared/bitbucket.properties.bak" do
      source 'bitbucket.properties.erb'
      owner new_resource.bitbucket_user
      group new_resource.bitbucket_group
      mode 00644
      action :create
      variables(
        properties: new_resource.bitbucket_properties
      )
      cookbook 'bitbucket_server'
      only_if { ::File.exist?("#{new_resource.home_path}/shared/bitbucket.properties.bak") }
    end
  end

  service new_resource.product do
    supports restart: true, start: true, stop: true, status: true
    action [:nothing]
    only_if "service #{new_resource.product} status"
  end
end
