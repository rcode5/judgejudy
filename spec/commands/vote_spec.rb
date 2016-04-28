require 'spec_helper'

describe Pardner::Commands::Vote, type: :bot do

  let(:member_data) do
    Hashie::Mash.new({id: 'user', profile: {email: 'jon@carbonfive.com', first_name: 'Jon'}})
  end

  let(:teams) {
    [
      Pardner::Team.create!(name: "Team 1", members: ['a@example.com', 'b@example.com']),
      Pardner::Team.create!(name: "Team 2", members: ['c@example.com', 'd@example.com']),
      Pardner::Team.create!(name: "Team 8", members: ['jon@carbonfive.com'])
    ]
  }
  before do
    teams
    Pardner::Member.new(member_data)
  end

  context "when voting for another team" do

    it "requires DM for voting" do
      expect(message: "give \"Team 2\" 1 golden horseshoe").to respond_with_slack_message(/We should keep that betwixt us two./)
    end

    it "casts a vote for a team given the command 'give \"Team 2\" 1 golden horseshoe' in a dm" do
      expect(channel: "DM", message: "give \"Team 2\" 1 golden horseshoe").to respond_with_slack_message("You got it! Team 2 gets :star: from you.")
      expect(Pardner::Vote.where(team: teams[1]).last.score).to eql 1
    end
    it "casts a vote for a team given the command 'give \"Team 2\" 1 golden horseshoe'" do
      expect(channel: "DM", message: "give \"Team 2\" 1 golden horseshoe").to respond_with_slack_message("You got it! Team 2 gets :star: from you.")
      expect(Pardner::Vote.where(team: teams[1]).last.score).to eql 1
      expect(channel: "DM", message: "Give \"Team 2\" 3 golden horseshoes").to respond_with_slack_message("You got it! Team 2 gets :star: :star: :star: from you.")
      expect(Pardner::Vote.where(team: teams[1]).last.score).to eql 3
    end

    it "if a user votes twice for the same team, the last vote is the one that is counted" do
      expect(channel: "DM", message: "give \"Team 1\" 2 golden horseshoes").to respond_with_slack_message(/.*/)
      expect(channel: "DM", message: "give \"Team 1\" 1 golden coin").to respond_with_slack_message(/.*/)
      expect(Pardner::Vote.where(team: teams.first).last.score).to eql 1
    end

    it "doesn't cast a vote for an invalid score" do
      expect(channel: "DM", message: "give \"Team 1\" 900 golden horseshoes").to respond_with_slack_message(/score belongs in a spitoon/)
    end

    it "doesn't cast a vote for an invalid team" do
      expect(channel: "DM", message: "Give \"Team nobody\" 4 golden horseshoes").to respond_with_slack_message(/That team is not on \*this\* prairie/)
    end
  end

  context "when voting for your own team" do
    it "requires DM for voting" do
      expect(message: "give my team 1 golden horseshoe").to respond_with_slack_message(/We should keep that betwixt us two./)
    end

    it "casts a vote for my team given the command 'cast a vote my team: 2'" do
      expect(channel: "DM", message: "give my team  2 golden horseshoes").to respond_with_slack_message(/.*/)
      expect(Pardner::Vote.where(team: teams.last).last.score).to eql 2
    end
    it "responds with a success message given 'give my team 2 golden horseshoes'" do
      expect(channel: "DM", message: "Give my team 2 golden horseshoes").to respond_with_slack_message(/You got it! You scored your team :star: :star:/)
    end
    it "respects your last vote" do
      expect(channel: "DM", message: "#{SlackRubyBot.config.user} give my team 2 golden coins").to respond_with_slack_message(/.*/)
      expect(channel: "DM", message: "#{SlackRubyBot.config.user} Give my team  4 golden coins").to respond_with_slack_message(/.*/)
      expect(Pardner::Vote.where(team: teams.last).last.score).to eql 4
    end
    it "responds with an error for an invalid vote" do
      expect(channel: "DM", message: "#{SlackRubyBot.config.user} give my team  9 golden shoes").to respond_with_slack_message(/belongs in a spitoon/)
    end

  end

  context "before you've voted" do
    it "returns with smack talk" do
      expect(channel: "DM", message: "#{SlackRubyBot.config.user} show my votes").to respond_with_slack_message(/Don't be daft/)
    end
  end

  context "when you've made some votes" do
    before do
      votes = [
        Hashie::Mash.new(team: { name: 'Rustlers' }, score: 4),
        Hashie::Mash.new(team: { name: 'whatever' }, score: 2)
      ]
      allow(Pardner::Vote).to receive(:where).and_return(votes)
    end
    it "shows my votes" do
      expect(message: "#{SlackRubyBot.config.user} show my votes").to respond_with_slack_message(/Rustlers : 4\nwhatever : 2/m)
    end
    it "does not show votes if pardner is not addressed" do
      expect(message: "show my votes").to not_respond
    end
  end


  context "when there are a pile of votes" do
    before do
      votes = {
        'the so and sos' => 4,
        'eating' => 2
      }
      allow(Pardner::Services::TeamVoteService).to receive(:tally_score).and_return(votes)
    end
    it "shows all votes when bot is addressed" do
      expected =/well, if that don't take the rag off the bush.*\s+ahead.*the so and sos : 4.*eating : 2/im
      expect(message: "#{SlackRubyBot.config.user} show all votes").to respond_with_slack_message(expected)
    end
    it "responds with nothing when bot is not addressed" do
      expect(message: "show all votes").to not_respond
    end
  end

end
