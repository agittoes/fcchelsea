source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'haml', '~> 4.0.3'
gem 'haml-rails', '~> 0.4'

gem 'mongoid', github: 'mongoid/mongoid'
gem 'bson_ext', '~> 1.8.6'

gem 'less-rails'
gem 'twitter-bootstrap-rails', '2.2.7'

gem 'omniauth-facebook', '~> 1.4.1'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
gem "omniauth-vkontakte", "~> 1.2.0"
gem 'omniauth-odnoklassniki', '~> 0.0.4'

gem 'carrierwave', '~> 0.9.0'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'mini_magick', '~> 3.6.0'

gem 'bb-ruby', require: 'bb-ruby'
gem 'koala', '~> 1.6.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'html2haml', '~> 1.0.1'
  gem 'erb2haml', '~> 0.1.5'

  # For RailsPanel in Goole Chrome
  gem 'meta_request'

  # Display errors trace in page
  gem 'better_errors', '~> 0.9.0'
  gem 'binding_of_caller', '~> 0.7.2'

  gem 'quiet_assets', '~> 1.0.2'
end

group :production do
  # Use yui-compressor as compressor for CSS assets
  gem 'yui-compressor', '~> 0.11.0'

  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano', group: :development
gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]