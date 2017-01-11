source 'https://rubygems.org'

gem 'rails', '4.2.7.1'
gem 'uglifier', '>= 2.7.2'

gem 'plek', '~> 1.11'
gem 'slimmer', '~> 10.0'

gem 'airbrake', '4.0.0'
gem 'logstasher', '0.5.3'

gem 'unicorn', '4.8.3'

if ENV['API_DEV']
    gem 'gds-api-adapters', :path => '../gds-api-adapters'
else
    gem 'gds-api-adapters', '36.0.0'
end

gem 'govuk_frontend_toolkit', '4.3.0'

group :development, :test do
  gem 'rspec-rails', '3.5.1'
  gem 'capybara', '2.7.1'
  gem 'webmock', '~> 1.18.0', :require => false

  gem 'govuk-content-schema-test-helpers', '1.3.0'

  gem 'simplecov-rcov', '0.2.3', :require => false
  gem 'govuk-lint', '1.2.0'

  gem 'jasmine-rails', '~> 0.10.6'
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
