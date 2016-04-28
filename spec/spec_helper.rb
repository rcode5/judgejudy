ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rspec'
require 'slack-ruby-bot/rspec'
require 'nokogiri'


cwd = File.dirname(__FILE__)

Dir[ File.join(cwd, './support/**/*.rb')].each { |f| require f }

require_relative '../pardner.rb'
require_relative '../web.rb'

# shut up
ActiveRecord::Base.logger = nil
