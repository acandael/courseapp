source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use postgres as the database for AR
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Foundation framework
gem 'zurb-foundation'
gem 'foundation-icons-sass-rails'
# Use Haml as viewengine
gem 'haml-rails'

# Use bcrypt for encrypting passwords
gem 'bcrypt-ruby', '~> 3.1.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'fabrication'
gem 'faker'

# gems for uploading and image processing
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'carrierwave_direct', "~> 0.0.13"
gem 'sidekiq'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test, :development do
  gem 'rspec-rails'
  gem 'simplecov'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
end

group :development do
  gem 'pry'
end

group :production do
  gem 'rails_12factor'
end
