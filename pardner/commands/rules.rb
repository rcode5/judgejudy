# coding: utf-8
module Pardner
  module Commands
    class Rules < SlackRubyBot::Commands::Base
      MESSAGE = [
        "The day of the Codeo, each team will pick an C5 Slack channel to use for inspiration for your project (e.g. find problems expressed by people in conversations).",
        "",
        "An actual slack integration is not required, but encouraged",
        "",
        "You must produce a pitch deck & demo illustrating the benefits of your product/project for the company.",
        "",
        "*Projects will be judged based on*",
        "• Company value (team happiness, project efficiency, moolah)",
        "• Slackiness (appropriateness to the channel, Slackbot or other integration)",
        "• Balanced team (everyone on the team was involved, had fun and had interesting problems to solve)",
      ].join("\n")

      match /rules of the west/ do |client, data, _match|
        client.say(channel: data.channel, text: MESSAGE)
      end
    end
  end
end
