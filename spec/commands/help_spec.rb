require 'spec_helper'

describe Pardner::Commands::Help, type: :bot do

  let(:member_data) do
    Hashie::Mash.new({id: 'user', profile: {email: 'jon@carbonfive.com', first_name: 'Jon'}})
  end

  before do
    Pardner::Member.new(member_data)
  end

  it 'responds with a help message when addressing @pardner' do
    expect(message: "#{SlackRubyBot.config.user} help").to respond_with_slack_message(/^Hey there cowpoke/)
  end

  it 'responds with a help message when pardner and help is in the message anywhere' do
    expect(message: "pardner help me").to respond_with_slack_message(/^Hey there cowpoke/)
  end

  it 'does not respond to help if pardner is not addressed' do
    expect(message: "help").to not_respond
  end

  it 'does not respond to help voting if pardner is not addressed' do
    expect(message: "help voting").to not_respond
  end

  it 'responds with a help message about voting if help voting and pardner are present' do
    expect(message: "#{SlackRubyBot.config.user} help voting").to respond_with_slack_message(/^So good of you/)
  end
end
