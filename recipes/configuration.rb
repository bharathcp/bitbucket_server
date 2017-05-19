directory("#{node['bitbucket']['home_path']}/shared") do
  owner node['bitbucket']['user']
  group node['bitbucket']['user']
  mode 00755
  action :create
  recursive true
end


template "#{node['bitbucket']['home_path']}/shared/bitbucket.properties" do
  source 'bitbucket.properties.erb'
  owner node['bitbucket']['user']
  group node['bitbucket']['user']
  mode 00644
  action :create
  variables(
    :properties => node['bitbucket']['properties']
  )
  notifies :restart, "service[#{node['bitbucket']['product']}]", :delayed
end
