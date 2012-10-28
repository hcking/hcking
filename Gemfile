source 'http://rubygems.org'

gem 'rails', '~> 3.2.8'
gem 'rake', '~> 0.9'

# Databases
gem 'sqlite3', '~> 1.3.5', group: :test
gem 'mysql2', '~> 0.3.11'

# Memcache Store
# DO NOT UPGRADE THIS
# We need exactly this version, because
# newer versions cant' connect to unix
# sockets. See here:
#
#  https://github.com/mperham/dalli/issues/229
#
gem 'dalli', '~> 1.1.5'

# Tags
gem 'acts-as-taggable-on', '~> 2.3.1'

# Asset template engines
gem 'sass-rails', '~> 3.2.3'
gem 'coffee-script', '~> 2.2.0'
# TODO: Investigate if we can take version instead of Repo
gem 'leaflet-rails', github: 'axyjo/leaflet-rails'
gem 'uglifier', '~> 1.2.0'
gem 'haml', '~> 3.1.4'
gem 'jquery-rails', '~> 2.0.0'
gem 'md_emoji', '~> 0.0.7'
gem 'redcarpet', '~> 2.1.0'

# Admin
# TODO: Investigate if we can take version instead of Repo
gem 'activeadmin', git: 'https://github.com/gregbell/active_admin.git'
# TODO: Add Version here
gem 'ckeditor_rails', require: 'ckeditor-rails'

# Monitoring
gem 'newrelic_rpm', '~> 3.4.0'

# Date Handling
gem 'ice_cube', '~> 0.8.0'
gem 'ri_cal', '~> 0.8.8'

# Authentication
gem 'devise', '~> 2.1.1'

# Authorization
gem 'cancan', '~> 1.6.7'

# Omniauth
# TODO: Add Versions here
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'

# Picture Upload
gem 'carrierwave', '~> 0.6.2'
gem 'mini_magick', '~> 3.4'

# MP3 Player
# TODO: Add Version here
gem 'mediaelement_rails'

# Form Handling
gem 'formtastic', '~> 2.2.0'
gem 'simple_form', '~> 2.0.4'

# JavaScript runtime
# TODO: Please investigate why both are here
gem 'execjs', '~> 1.4.0'
gem 'therubyracer', '~> 0.10.1'

# Clipboard-Button on iCal Page
gem 'zero-clipboard-rails', '~> 1.0.1'
# User Picture using Gravatar
gem 'gravatar_image_tag', '~> 1.1.0'
# Truncate HTML on SingleEvent Pages
gem 'html_truncator', '~> 0.3.0'

# Frontend
# TODO: Add Version here
gem 'bootstrap-sass-rails'
gem 'smurfville'

# Pagination
# TODO: Add Version here
gem 'bootstrap-kaminari-views'

# PJAX
# TODO: Add Version here
gem 'pjax_rails'

# Facebook style tooltip jQuery plugin
gem 'tipsy-rails', '~> 1.0.2'

# Sample Data
# TODO: Investigate if this belongs to the development group
gem 'faker', '1.0.1'

# Other dependencies
gem 'gabba', '~> 0.3.0'
gem 'geocoder', '~> 1.0'
# TODO: Add Version here
gem 'simple-navigation'

group :development do
  # Deployment
  gem 'vlad', '~> 2.2.3', require: false
  gem 'vlad-git', '~> 2.2.0', require: false

  group :darwin do
    gem 'rb-fsevent', '~> 0.9.0pre4'
    gem 'growl', '~> 1.0.3'
  end

  # Guard
  gem 'guard', '~> 1.3.0'
  gem 'guard-test', '~> 0.5.0'
  gem 'guard-pow', '~> 1.0.0'
  gem 'guard-bundler', '~> 1.0.0'
end

group :test do
  gem 'factory_girl_rails', '~> 3.5', require: false
  gem 'spork-testunit', '~> 0.0.7'
  gem 'mocha', '~> 0.12.0', require: false
end
