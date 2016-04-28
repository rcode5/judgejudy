require 'spec_helper'

describe Pardner::Commands::Rules, type: :bot do
  it 'responds with the rules of the game' do
    expect(message: 'rules of the west').to respond_with_slack_message(/Projects will be judged based on/)
  end
end