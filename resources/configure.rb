#
# Cookbook:: bitbucket_server
# Resource:: configure
#
property :product, String, default: 'bitbucket'
property :home_path, String, default: '/var/atlassian/application-data/bitbucket'
property :bitbucket_user, String, default: 'atlbitbucket'
property :bitbucket_group, String, default: 'atlbitbucket'
property :bitbucket_properties, Hash, required: false

action :create do
  directory "#{new_resource.home_path}/shared" do
    owner new_resource.bitbucket_user
    group new_resource.bitbucket_group
    mode 00755
    action :create
    recursive true
    # notifies :restart, "service[#{new_resource.product}]", :delayed
  end

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
