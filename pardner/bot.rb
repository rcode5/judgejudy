module Pardner
  class Bot < SlackRubyBot::Bot
    SlackRubyBot::App.include Pardner::Hooks::Hello

    def self.call(client, data, _match)
      client.say(channel: data.channel, text: "What in tarnation are you blatherin about, <@#{data.user}>?", gif: 'cowboy')
    end

  end
end
