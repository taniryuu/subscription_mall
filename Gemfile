source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
gem 'bootstrap', '~> 4.1.1'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'faker'#サンプル追加
gem 'will_paginate' #ページネート
gem 'bootstrap-will_paginate'#ページネート
gem 'will_paginate-bootstrap4'#ページネート
gem 'owlcarousel-rails'#カルーセル
gem 'devise'
gem 'paranoia', '~> 2.3', '>= 2.3.1'#論理削除
gem 'font-awesome-rails'
gem 'carrierwave', '~> 2.0'#複数画像投稿のgem
gem 'cloudinary'
gem 'rmagick'#画像をリサイズしたりする
gem 'rails-i18n'
gem 'devise-i18n'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2', '~> 0.8.0'
gem 'omniauth-instagram'
gem 'dotenv-rails'
gem 'omniauth-line'
gem 'omniauth-oauth2', '>= 1.6'
gem 'stripe'
gem 'geocoder'#googlemap用
gem 'gon'#googlemapお店一覧用
gem 'rqrcode' #QRコード用
# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'mini_racer'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'phony_rails' # 電話番号
gem 'twilio-ruby'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'mysql2'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'webdrivers'
  gem 'launchy', '~> 2.4.3'
  gem 'selenium-webdriver'
  gem "rspec_junit_formatter"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :production do
  gem 'pg', '0.20.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
