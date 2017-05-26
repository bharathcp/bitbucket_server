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
        if (line[0] != ?# and line[0] != ?=)
          i = line.index('=')
          if (i)
            properties[line[0..i - 1].strip] = line[i + 1..-1].strip
          else
            properties[line] = ''
          end
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
      # notifies :restart, "service[#{new_resource.product}]", :delayed
    end
  end
end
