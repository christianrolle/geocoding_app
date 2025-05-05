source 'https://rubygems.org'

ruby '3.2.8'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.5', '>= 7.1.5.1'
gem 'pg', '>= 1.1', '< 2.0'
gem 'puma', '~> 6.0'
gem 'slim-rails', '~> 3.7'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# flexible authentication solution for Rails based on Warden
gem 'devise'
# geocoding solution for Ruby; allows to wire several external APIs
gem 'geocoder'

group :development do
  # Preview email in the default browser instead of sending it (e.g. Devise emails)
  gem 'letter_opener_web'
end

group :test do
  # fixtures replacement with a straightforward definition syntax (Factory pattern)
  gem 'factory_bot_rails'
  # helps testing app by simulating how a real user would interact with it
  gem 'capybara'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-rails'
  # library for stubbing and setting expectations on HTTP requests
  gem 'webmock'
end
