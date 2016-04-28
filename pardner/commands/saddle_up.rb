module Pardner
  module Commands
    class SaddleUp < SlackRubyBot::Commands::Base
      MESSAGE = [
        "Well hey there buckaroo! So you want to build a Slackbot?",
        "",
        "Well, a bit of history for you. Before Slack there was IRC",
        "",
        "https://en.wikipedia.org/wiki/IRC_bot",
        "",
        "But that was then. Here's more about Slack, according to Hoyle",
        "",
        "https://api.slack.com/bot-users",
        "https://api.slack.com/slash-commands",
        "",
        "*A few frameworks for developing bots*",
        "• https://github.com/dblock/slack-ruby-bot",
        "• https://github.com/howdyai/botkit",
        "",
        "*A few tutorials*",
        "• https://blog.heroku.com/archives/2016/3/9/how-to-deploy-your-slack-bots-to-heroku",
        "• http://blog.npmjs.org/post/128237577345/how-to-build-a-slackbot-deploy-an-app-to-heroku",
        "• https://slackhq.com/a-beginner-s-guide-to-your-first-bot-97e5b0b7843d?gi=c5970d28b18",
        "• https://github.com/mccreath/isitup-for-slack/blob/master/docs/TUTORIAL.md",
        "",
        "\"Chaotic action is preferable to orderly inaction.\""
      ].join("\n")

      match /saddle up!?/ do |client, data, _match|
        client.say(channel: data.channel, text: MESSAGE)
      end
    end
  end
end

