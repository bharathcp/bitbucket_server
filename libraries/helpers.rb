# Cookbook:: bitbucket_server
# Library:: helpers
# Authors:: Bharath (bahrathcp@gmail.com), Raghu (graghav@gmail.com)

module BitbucketServer
  module Helpers
    # ensure version in semver format MAJOR.MINOR.PATCH
    def validate_version
      return if new_resource.version =~ /\d+.\d+.\d+/
      Chef::Log.fatal("The version must be in MAJOR.MINOR.PATCH format. Passed value: #{new_resource.version}")
      raise "The version must be in MAJOR.MINOR.PATCH format. Passed value: #{new_resource.version}"
    end
  end
end
