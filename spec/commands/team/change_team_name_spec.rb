require 'spec_helper'

describe Pardner::Commands::Team::ChangeTeamName, type: :bot do
  let(:member_data) do
    Hashie::Mash.new({id: 'user', profile: {email: 'a@example.com', first_name: 'Jon'}})
  end
  let(:team) { Pardner::Team.create(name: 'Team 4', members: [ member_data.profile.email ]) }

  before do
    Pardner::Member.new(member_data)
    team
  end

  it 'a team member can change the teams name' do
    expect(message: '"Team 4" shall now be known as "The Rustlers"').to respond_with_slack_message("That's a right smart name for all y'all. You'll likely be the bettermost now that yer called The Rustlers.")
    expect(team.reload.name).to eql 'The Rustlers'
  end

  it "you can't change another teams name" do
    expect(message: '"Team 5" shall now be known as "The Rustlers"').to respond_with_slack_message("You can't slumguzzle me. If you were in all the shoot, I'd let ya change their name, but you ain't so I won't.")
  end

  it "you can't your team name to empty" do
    expect(message: '"Team 4" shall now be known as ""').to respond_with_slack_message("Trying to bamboozle me, are ya?")
  end

  it "you can't your team name to an exisiting team's name" do
    Pardner::Team.create(name: 'Shuckers')
    expect(message: '"Team 4" shall now be known as "Shuckers"').to respond_with_slack_message("You can't slumguzzle me. If you were in all the shoot, I'd let ya change their name, but you ain't so I won't.")
  end

end
