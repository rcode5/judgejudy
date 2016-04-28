module Pardner
  module Commands
    class Story < SlackRubyBot::Commands::Base
      MESSAGE = [
        "Glad you asked!",
        "",
        "I was born quickly in a storm of google queries and last minute ideas. My home is https://github.com/carbonfive/codeo-bot, you can learn more about me there!"
      ].join("\n")

      match /what'?s\s+(your|yer)\s+story,? pardner\??/i do |client, data, match|
        client.say channel: data.channel, text: MESSAGE
      end

      command "what's your story", "whats your story", "what's your story?" do |client, data, match|
        client.say channel: data.channel, text: MESSAGE
      end
    end
  end
end
