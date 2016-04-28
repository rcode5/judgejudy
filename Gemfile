source 'http://rubygems.org'
ruby '2.3.0'
gem "rake"
gem "activerecord"
gem "pg"

gem 'puma'
gem 'sinatra'
gem "sinatra-activerecord"

gem 'slack-ruby-bot'
gem 'dotenv'

gem 'slim'

group :development, :test do
  gem 'foreman'
  gem 'rspec'
  gem 'rspec-collection_matchers'
  gem 'rack-test'
  gem 'byebug'
  gem 'rerun'
end

group :test do
# for slackbot test harness
  gem 'vcr'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'poltergeist'
end
