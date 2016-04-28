require 'spec_helper'

describe Pardner::Commands::Team::WhosIn, type: :bot do

  before do
    Pardner::Team.create(name: 'Rustlers')
  end

  it 'responds to `whos in` with a list of teams' do
    expect(message: "Who's in?").to respond_with_slack_message(/Glad you inquired/)
    expect(message: "who's in").to respond_with_slack_message(/Rustlers/)
  end
end
