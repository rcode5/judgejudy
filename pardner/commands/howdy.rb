module Pardner
  module Commands
    class Howdy < SlackRubyBot::Commands::Base
      match 'howdy pardner' do |client, data, match|
        answer(client, data, match)
      end

      command 'howdy' do |client, data, match|
        answer(client, data, match)
      end

      private

      def self.answer(client, data, match)
        user = Pardner::Member.find(data.user)
        team = Pardner::Team.all.detect { |team| team.member? user.email }

        message = "Howdy #{user.first_name}, welcome to the Spring 2016 Codeo!\n\n"
        if team
          message += "Meet your team\n```"
          team.members.each.with_index do |email, index|
            member = Pardner::Member.by_email email
            if member
              message += "<@#{member.id}> #{member.real_name}"
              message += " (captain)" if index == 0
              message += "\n"
            else
              message += "#{email}\n"
            end
          end
          message += "```"
          message += "\nYippi-aye-ay #{team.name}!"
        else
          message += "Well, shiver me timbers. I don't know what team you're on. You should talk to <@david>."
        end

        client.say(channel: data.channel, text: message)
      end
    end
  end
end
