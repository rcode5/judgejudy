module Pardner
  module Commands

    module Team
      class WhosIn < SlackRubyBot::Commands::Base

        def self.message
          teams = Pardner::Team.all
          msg = [ "Glad you inquired.", "The teams are:" ]

          msg += teams.map { |team| "#{team.name}: lead by #{Pardner::Member.slack_name(team&.members&.first)}" }
          msg.join("\n")
        end

        scan /^who\'?s in\??$/i do |client, data, match|
          client.say(channel: data.channel, text: message)
        end

      end

    end
  end
end
