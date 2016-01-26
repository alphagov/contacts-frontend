source 'https://rubygems.org'


gem 'rails', '4.1.14.1'
gem 'uglifier', '>= 2.7.2'

gem 'plek', '~> 1.11'
gem 'slimmer', '9.0.0'

gem 'airbrake', '4.0.0'
gem 'logstasher', '0.5.3'

gem 'unicorn', '4.8.3'

gem 'spring',      group: :development

if ENV['API_DEV']
    gem 'gds-api-adapters', :path => '../gds-api-adapters'
else
    gem 'gds-api-adapters', '20.1.1'
end

gem 'govuk_frontend_toolkit', '4.3.0'

group :development, :test do
  gem 'rspec-rails', '2.14.2'
  gem 'capybara', '2.3.0'
  gem 'webmock', '~> 1.18.0', :require => false

  gem 'govuk-content-schema-test-helpers', '1.3.0'

  gem 'simplecov-rcov', '0.2.3', :require => false
end
