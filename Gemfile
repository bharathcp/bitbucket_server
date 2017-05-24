source 'https://rubygems.org'

gem 'rake'

group :test, :integration do
  gem 'berkshelf', '~> 4.0'
end

group :test do
  gem 'chefspec'
  gem 'cookstyle'
  gem 'foodcritic'
end

group :integration do
  gem 'busser-serverspec', '~> 0.2.6'
  gem 'kitchen-vagrant', '~> 0.15'
  gem 'kitchen-docker'
  gem 'kitchen-dokken'
  gem 'test-kitchen', '~> 1.3'
  gem 'inspec'
  gem 'kitchen-inspec'
end

group :release do
  gem 'stove', '~> 5.2.0'
end