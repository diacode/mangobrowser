source 'https://rubygems.org'
ruby '2.1.4'

gem 'sinatra'
gem 'mangopay', git: 'https://github.com/javiercr/mangopay2-ruby-sdk.git'
gem 'thin'
gem 'sinatra-contrib'
gem 'rack-flash3',       require: 'rack-flash'
gem 'rack-ssl',          require: 'rack/ssl'
gem 'sprockets'
gem 'sprockets-sass'
gem 'sprockets-helpers', require: 'sinatra/sprockets-helpers'
group :test do
  gem 'rspec'
  gem 'rack-test'
end

group :development do
  gem 'byebug'
end

group :assets do
  gem 'haml'
  gem 'uglifier'
  gem 'coffee-script'
  gem 'sass'
  gem 'bootstrap-sass'
end

group :production do
  gem 'unicorn'
end
