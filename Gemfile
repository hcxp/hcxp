source 'https://rubygems.org'
ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'rails-i18n'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem "sprockets-es6"

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'devise'
gem 'devise-i18n'

gem 'slim-rails'

gem "autoprefixer-rails"

gem "cells"
gem "cells-rails", github: 'trailblazer/cells-rails'
gem "cells-slim", github: 'trailblazer/cells-slim'

gem 'geokit-rails'

gem 'pg_search'

gem 'active_link_to'

gem 'kaminari'

gem "pundit"

gem 'draper', github: 'drapergem/draper'

gem 'dotenv-rails'

gem 'mini_magick'
gem 'fog-aws'
gem 'carrierwave', '>= 1.0.0.rc', '< 2.0'

# Thumbor client
gem 'thumbor_rails'

# SEO
gem 'meta-tags'

# Countries metadata
gem 'countries', require: 'countries/global'

# Website scrap
gem 'metainspector'

# Background jobs
gem 'sidekiq'

# Settings
gem "rails-settings-cached"

# Oauth2 provider
gem 'doorkeeper'

# Friendly ids
gem 'friendly_id', '~> 5.1.0'

# Markdown
gem 'redcarpet'

# Dates delocalization
gem "delocalize"

# Slack notifications
gem 'slack-notifier'

# Statistics
gem 'impressionist'

# Slugs
gem 'babosa'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'faker'

  # Procfile
  gem 'foreman'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production, :staging do
  gem "sentry-raven"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
