module Pardner
  module Hooks
    module Hello
      extend SlackRubyBot::Hooks::Base

      def hello(client, data)
        response = client.web_client.users_list.find { |item| item[0] == "members" }.last
        response.map { |user| Pardner::Member.new user }
      end
    end
  end
end
