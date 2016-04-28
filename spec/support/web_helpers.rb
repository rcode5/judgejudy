require 'capybara'
require 'capybara/dsl'

module Pardner
  module WebHelpers
    include Rack::Test::Methods
    include Capybara::DSL
    def app
      Pardner::Web
    end
  end
end

RSpec.configure do |config|
  config.include Pardner::WebHelpers, type: :web
end
