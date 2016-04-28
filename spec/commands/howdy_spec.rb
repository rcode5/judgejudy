require 'spec_helper'

describe Pardner::Commands::Howdy, type: :bot do
  let(:member_data) do
    Hashie::Mash.new({id: 'user', profile: {email: 'jon@carbonfive.com', first_name: 'Jon'}})
  end

  before do
    Pardner::Team.create name: 'Team 8', members: [ member_data.profile.email ]
    Pardner::Member.new(member_data)
  end

  context 'when the member is in a team' do
    EXPECTED_BASIC_RESPONSE = /Jon, welcome to the Spring 2016 Codeo/

    it 'responds to howdy' do
      expect(message: "howdy").to respond_with_slack_message(EXPECTED_BASIC_RESPONSE)
    end

    it 'responds to pardner' do
      expect(message: "pardner").to respond_with_slack_message(EXPECTED_BASIC_RESPONSE)
    end

    it 'responds to @pardner howdy' do
      expect(message: "#{SlackRubyBot.config.user} howdy").to respond_with_slack_message(EXPECTED_BASIC_RESPONSE)
    end

    it "returns a list of your team members" do
      expect(message: "#{SlackRubyBot.config.user} howdy").to respond_with_slack_message(/Team 8!/)
      expect(message: "#{SlackRubyBot.config.user} howdy").to respond_with_slack_message(/\@user/)
    end
  end

  context 'When the member is not on any teams' do
    before do
      unknown_user = double(email: 'unknown_person@carbonfive.com', first_name: 'nobody')
      allow(Pardner::Member).to receive(:find).and_return(unknown_user)
    end
    it 'responds with appropriate error message' do
      expect(message: 'howdy').to respond_with_slack_message(/shiver me timbers/)
    end
  end
end
