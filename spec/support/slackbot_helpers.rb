module Pardner
  module SlackbotHelpers
    def app
      Pardner::Bot.instance
    end
  end
end

RSpec.configure do |config|
  config.include Pardner::SlackbotHelpers, type: :bot
end