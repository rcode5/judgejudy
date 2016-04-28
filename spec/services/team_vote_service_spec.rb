require 'spec_helper'

describe Pardner::Services::TeamVoteService do

  subject(:svc) { described_class }

  let(:team1) { Pardner::Team.create(name: 'Cow', members: ['a@example.com', 'b@example.com']) }
  let(:team2) { Pardner::Team.create(name: 'Horse', members: ['b@example.com']) }
  let(:teams) { [ team1, team2 ] }

  before do
    Pardner::Vote.create!(member_email: 'a@example.com', team: team1, score: 1)
    Pardner::Vote.create!(member_email: 'b@example.com', team: team1, score: 4)
    Pardner::Vote.create!(member_email: 'a@c5.com', team: team1, score: 1)
    Pardner::Vote.create!(member_email: 'e@c5.com', team: team2, score: 5)
    Pardner::Vote.create!(member_email: 'e@c5.com', team: team1, score: 2)
  end

  describe '.tally_score' do

    subject(:tally) { svc.tally_score }
    it 'returns tallied votes by team name' do
      expect(tally).to have(2).items
      expect(tally.keys).to match_array Pardner::Team.all.map(&:name)
    end

    it 'the total scores do not include votes by people on their own team' do
      expect(tally[team1.name]).to eql 1.5
      expect(tally[team2.name]).to eql 5.0
    end

    it 'the tally is sorted by score' do
      expect(tally.values).to eql [5.0,1.5]
    end

  end

  describe '.tally_morale' do

    subject(:tally) { svc.tally_morale }
    it 'returns tallied votes by team name' do
      expect(tally).to have(2).items
      expect(tally.keys).to match_array Pardner::Team.all.map(&:name)
    end

    it 'the total scores do not include votes by people on other teams' do
      expect(tally[team1.name]).to eql 2.5
      expect(tally[team2.name]).to eql 0.0
    end

    it 'the tally is sorted by score' do
      expect(tally.values).to eql [2.5,0.0]
    end

  end


end
