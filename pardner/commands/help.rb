module Pardner
  module Commands
    class Help < SlackRubyBot::Commands::Base
      HELP_MESSAGE = [
        "Hey there cowpoke! Here's a pile of stuff that I can do",
        "```",
        "howdy(pardner) -- learn who is on your team",
        "whos in? -- list of team names",
        "what's your story(, pardner?) -- learn about developing pardner",
        "saddle up! -- learn all about slackbot development",
        "rules of the west -- official codeo rules",
        "show my votes -- show the votes i've made",
        "show all votes -- current team standing",
        "\"<team name>\" shall now be known as \"<new name>\" -- change your team name",
        "help -- see this message (you must address me to get these)",
        "help voting -- help around commands to cast votes (you must address me to get these)",
        "```",
        ":horse_racing:"
      ].join("\n")

      VOTING_HELP_MESSAGE = [
        "So good of you to think about votin'.  It should be a piece o pie.  Even a Jasper could handle it.\n\n",
        "Votes range from 0 (the worst) to 5 (the best).  You should vote for all the teams (including your own)\n",
        "When you for your team, it should be about how much they made you want to cut a caper (5) or cut and run (0)\n",
        "When you vote for other teams, vote on whether their project was more like cow-puckie (0) or more like parade chaps (5)\n",
        "You can vote multiple times.  Only your last vote for a team (yours or others) will be counted.",
        "You can lookup team names with `who's in?'\n",
        "To cast a vote:",
        "```",
        "Give \"<team name>\" <score> golden horseshoes",
        "Give my team <score> golden horseshoe",
        "```",
        "e.g. \'Give \"The Rustlers\" 4 golden horseshoes\'",
        ":star:"
      ].join("\n")

      match /pardner.*\s+help\s+/ do |client, data, match|
        msg = (data.text.include? 'voting') ? VOTING_HELP_MESSAGE : HELP_MESSAGE
        client.say(channel: data.channel, text: msg)
      end

      command 'help', 'help voting' do |client, data, match|
        msg = (data.text.include? 'voting') ? VOTING_HELP_MESSAGE : HELP_MESSAGE
        client.say(channel: data.channel, text: msg)
      end

    end
  end
end
