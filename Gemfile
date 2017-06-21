source 'https://rubygems.org'

gem 'rake'

group :test, :integration do
  gem 'berkshelf'
end

group :test do
  gem 'chefspec'
  gem 'codeclimate-test-reporter', '~> 1.0.0'
  gem 'cookstyle'
  gem 'foodcritic'
  gem 'simplecov'
  gem 'codeclimate-test-reporter'
end

group :integration do
  gem 'busser-serverspec'
  gem 'inspec'
  gem 'kitchen-docker'
  gem 'kitchen-dokken'
  gem 'kitchen-inspec'
  gem 'kitchen-vagrant'
  gem 'test-kitchen'
end

group :release do
  gem 'github_changelog_generator'
  gem 'stove'
end
