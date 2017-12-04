source 'https://rubygems.org'
ruby '2.4.2'

gem 'puma'

gem 'rake'
gem 'hanami',       '~> 1.1'
gem 'hanami-model', '~> 1.1'

gem 'dry-struct'

# healthcheck
gem 'wet-health_endpoint'

gem 'pg'

gem 'slim'
gem 'hanami-bootstrap', '0.4'
gem 'sass'

gem 'hanami-pagination', git: 'https://github.com/jodosha/hanami-pagination.git', branch: 'fix/hanami-repository-superclass'

# api
gem 'hanami-serializer', github: 'davydovanton/hanami-serializer'
gem 'graphql'

gem 'sidekiq'
gem 'sidekiq-scheduler'

gem 'dry-system'

gem 'redis', '~>3.2'
gem 'hiredis'
gem 'mock_redis'
gem 'connection_pool'

# group :plugins do
#   gem 'hanami-reloader'
# end
#
group :development do
  gem 'guard-puma'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'rspec'
  gem 'rspec-hanami'
  gem 'capybara'
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov', require: false
end
