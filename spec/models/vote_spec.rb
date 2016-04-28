require 'spec_helper'

describe Pardner::Vote do

  let(:team) { Pardner::Team.create(name: "Team 1", members: ['jon@c5.com']) }

  it "requires a valid team" do
    vote = Pardner::Vote.new(team: team, member_email: 'jon@c5.com', score: 1)
    expect(vote).to be_valid
  end

  it "returns errors without a valid team" do
    invalid_vote = Pardner::Vote.new(team_id: 10000, member_email: 'jon@c5.com', score: 1)
    expect(invalid_vote).to_not be_valid
    expect(invalid_vote.errors[:team].first).to include 'Whoa, Nelly'
  end

end
