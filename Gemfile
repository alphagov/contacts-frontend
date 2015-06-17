source 'https://rubygems.org'


gem 'rails', '4.1.11'
gem 'uglifier', '>= 1.3.0'

gem 'plek', '~> 1.8.1'
gem 'slimmer', '8.2.1'

gem 'airbrake', '4.0.0'
gem 'logstasher', '0.5.3'

gem 'unicorn', '4.8.3'

gem 'spring',      group: :development

if ENV['API_DEV']
    gem 'gds-api-adapters', :path => '../gds-api-adapters'
else
    gem 'gds-api-adapters', '12.2.0'
end

gem 'govuk_frontend_toolkit', "1.3.0"

group :development, :test do
  gem 'rspec-rails', '2.14.2'
  gem 'capybara', '2.3.0'
  gem 'webmock', '~> 1.18.0', :require => false

  gem 'simplecov-rcov', '0.2.3', :require => false
end
