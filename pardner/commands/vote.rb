module Pardner
  module Commands
    class Vote < SlackRubyBot::Commands::Base
      match /give \"(?<team_name>.*[^\"])\"\s+(?<score>\d+)\s+golden.*/i do |client, data, match|
        if !direct_message?(data)
          msg = "We should keep that betwixt us two.  DM me to cast your votes"
        else
          team_name = match[:team_name]
          user = Pardner::Member.find(data.user)
          vote = vote_for(user.email, team_name )
          vote.score = match[:score]
          msg = if vote.save
                  conjugated_point = "point" + ((vote.score != 1) ? 's' : '')
                  "You got it! #{team_name} gets #{stars(vote.score)} from you."
                else
                  vote.errors.values.join ". "
                end
        end
        client.say channel: data.channel, text: msg
      end

      match /give my team\s+(?<score>\d+)\s+golden.*/i do |client, data, match|
        if !direct_message?(data)
          msg = "We should keep that betwixt us two.  DM me to cast your votes"
        else
          user = Pardner::Member.find(data.user)
          team = Pardner::Team.all.find { |team| team.member? user.email }
          vote = vote_for(user.email, team.name)
          vote.score = match[:score]
          msg = if vote.save
                  "You got it! You scored your team #{stars(vote.score)}"
                else
                  vote.errors.values.join ". "
                end
        end
        client.say channel: data.channel, text: msg
      end

      command "show my votes" do |client, data, match|
        user = Pardner::Member.find(data.user)
        votes = Pardner::Vote.where(member_email: user.email)
        message = nil
        if votes.count > 0
          message = [
            "You've been sweeping the range there! Here's what I got for you:",
            "```",
            votes.map { |vote| "#{vote.team.name} : #{vote.score}" }.join("\n"),
            "```"
          ].join("\n")
        else
          message = "Don't be daft. You need to vote before I have something to show you."
        end
        client.say channel: data.channel, text: message
      end

      command 'show all votes' do |client, data, match|
        scores = Pardner::Services::TeamVoteService.tally_score
        message = [
          "Well, if that don't take the rag off the bush.",
          ((scores.first.last > 0) ? "#{scores.first.first} is ahead." : ""),
          "```",
          scores.map { |team, score| "#{team} : #{score}" }.join("\n"),
          "```"
        ]
        client.say(channel: data.channel, text: message)
      end

      private

      def self.stars(score)
        score.times.map{ ":star:" }.join " "
      end

      def self.vote_for member_email, team_name
        team = Pardner::Team.find_by(name: team_name)
        vote = Pardner::Vote.find_by(member_email: member_email, team: team)
        vote || Pardner::Vote.new(member_email: member_email, team: team)
      end
    end
  end
end
