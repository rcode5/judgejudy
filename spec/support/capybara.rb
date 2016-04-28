require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require_relative '../../web'
Capybara.configure do |config|
  config.default_driver = :rack_test
  config.app = Pardner::Web.new
end
