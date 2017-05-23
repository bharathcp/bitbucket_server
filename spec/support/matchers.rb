def put_ark(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :put, resource_name)
end

def install_bitbucket(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:bitbucket_install, :install, resource_name)
end

def config_bitbucket(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:bitbucket_config, :create, resource_name)
end

def service_bitbucket(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:bitbucket_service, :create, resource_name)
end