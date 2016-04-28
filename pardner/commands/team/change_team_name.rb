module Pardner
  module Commands
    module Team
      class ChangeTeamName < SlackRubyBot::Commands::Base

        match /^\"(?<old_name>[^\"]*)\" shall now be known as \"(?<new_name>[^\"]*)\"$/ do |client, data, match|
          old_name = match[:old_name]
          new_name = match[:new_name]
          if !old_name.present? || !new_name.present?
            client.say(channel: data.channel, text: "Trying to bamboozle me, are ya?")
          else
            team = Pardner::Team.find_by(name: old_name)
            user = Pardner::Member.find(data.user)

            msg = "You can't slumguzzle me. If you were in all the shoot, I'd let ya change their name, but you ain't so I won't."
            if team && team.member?(user.email) && team.update(name: new_name)
              msg = "That's a right smart name for all y'all. You'll likely be the bettermost now that yer called #{team.name}."
            end
            client.say(channel: data.channel, text: msg)
          end

        end

      end

    end
  end
end
