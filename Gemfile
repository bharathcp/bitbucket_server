source 'https://rubygems.org'

gem 'rake'

group :test, :integration do
  gem 'berkshelf', '~> 4.0'
end

group :test do
  gem 'chefspec'
  gem 'cookstyle'
  gem 'foodcritic'
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0.0'
end

group :integration do
  gem 'busser-serverspec', '~> 0.2.6'
  gem 'inspec'
  gem 'kitchen-docker'
  gem 'kitchen-dokken'
  gem 'kitchen-inspec'
  gem 'kitchen-vagrant', '~> 0.15'
  gem 'test-kitchen', '~> 1.3'
end

group :release do
  gem 'github_changelog_generator'
  gem 'stove', '~> 5.2.0'
end
