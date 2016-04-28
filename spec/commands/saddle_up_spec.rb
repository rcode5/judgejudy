require 'spec_helper'

describe Pardner::Commands::SaddleUp, type: :bot do
  it 'responds to `saddle up` with the documentation' do
    expect(message: 'saddle up').to respond_with_slack_message(/api.slack.com\/bot-users/)
  end

  it 'responds to `saddle up!` with the documentation' do
    expect(message: 'saddle up!').to respond_with_slack_message(/api.slack.com\/bot-users/)
  end
end