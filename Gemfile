source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Use Redis adapter to run Action Cable in production
gem 'hiredis', '~> 0.6.3'
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
gem 'image_processing', '~> 1.2'

gem 'turbo-rails', '~> 0.5.9'
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'pagy', '~> 3.10'
gem "view_component", require: "view_component/engine"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'spring'
gem 'faker', '~> 2.15', '>= 2.15.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
  gem 'factory_bot_rails', '~> 6.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'database_cleaner', '~> 1.8', '>= 1.8.5'
  gem 'simplecov', '~> 0.21.2', require: false

  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'spring-commands-rspec'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # rexml no default in ruby 3.0, -> required for specs 
  gem 'rexml', '~> 3.2', '>= 3.2.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
