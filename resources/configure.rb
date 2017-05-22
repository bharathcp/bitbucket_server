#
# Cookbook:: bitbucket_server
# Resource:: configure
#
property :product, String, default: node['bitbucket']['product']
property :home_path, String, default: node['bitbucket']['home_path']
property :bitbucket_user, String, default: node['bitbucket']['user']
property :bitbucket_group, String, default: node['bitbucket']['group']
property :bitbucket_properties, Hash, required: false, default: node['bitbucket']['properties']

action :create do

  directory "#{new_resource.home_path}/shared" do
    owner new_resource.bitbucket_user
    group new_resource.bitbucket_group
    mode 00755
    action :create
    recursive true
  end

  template "#{new_resource.home_path}/shared/bitbucket.properties" do
    source 'bitbucket.properties.erb'
    owner new_resource.bitbucket_user
    group new_resource.bitbucket_group
    mode 00644
    action :create
    variables(
      :properties => new_resource.bitbucket_properties
    )
    #notifies :restart, "service[new_resource.product]", :delayed
  end

end

