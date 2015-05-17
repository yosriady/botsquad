ruby '2.2.0'
source 'https://rubygems.org'

gem 'rails', '4.2.1'

# DB
gem 'pg'

# Application Server
gem 'passenger'

# User Authentication
gem 'devise'

# Errors
gem 'raygun4ruby'

# Agents
gem 'phantomjs'
gem 'sidekiq'

# Sidekiq Web UI
gem 'sinatra', :require => nil

# Agent Supporting Libs
# gem 'diffy'

# API
gem 'rails-api'
gem 'active_model_serializers', '0.10.0.rc1'
gem 'kaminari'
gem 'friendly_id'
gem 'json'
gem 'rest-client'

# Active Record
gem 'haikunator'
gem 'aasm'
gem 'validate_url'

# Validations
gem 'json-schema'
gem 'validates_email_format_of'

# Frontend
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'spring'
  gem 'rails-erd'
end

group :development, :test do
  gem 'dotenv-rails'
end

