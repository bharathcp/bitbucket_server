if defined?(ChefSpec)
  def install_bitbucket(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:bitbucket_install, :install, resource_name)
  end

  def config_bitbucket(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:bitbucket_config, :create, resource_name)
  end

  def service_bitbucket(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:bitbucket_service, :create, resource_name)
  end

  def backup_client(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:backup_client, :install, resource_name)
  end

end
