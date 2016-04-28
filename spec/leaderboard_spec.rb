require 'spec_helper'

describe 'Leaderboard', type: :web do
  let(:team1) { Pardner::Team.create! name: 'Cow Pokes', members: ['a@c5.com', 'b@c5.com', 'c@c5.com'] }
  let(:team2) { Pardner::Team.create! name: 'Little Doggies', members: ['e@c5.com'] }

  before do
    Pardner::Vote.create!(member_email: 'a@c5.com', team: team1, score: 1)
    Pardner::Vote.create!(member_email: 'e@c5.com', team: team2, score: 5)
    Pardner::Vote.create!(member_email: 'e@c5.com', team: team1, score: 2)
    visit "/"
  end

  it 'shows 2 tables with leaderboard data' do
    expect(page).to have_css('.container_content_section', count: 2)
  end

  it 'shows a table of the votes by non members' do
    section = all('.container_content_section').first

    rows = section.all('ul li')
    within rows.first do
      expect(page).to have_content '2'
      expect(page).to have_content 'Cow Pokes'
    end
    within rows.last do
      expect(page).to have_content '0'
      expect(page).to have_content 'Little Doggies'
    end

  end

  it 'shows a table of the votes by members about their own team' do
    section = all('.container_content_section').last

    rows = section.all('ul li')
    within rows.first do
      expect(page).to have_content '5'
      expect(page).to have_content 'Little Doggies'
    end
    within rows.last do
      expect(page).to have_content '1'
      expect(page).to have_content 'Cow Pokes'
    end

  end

end
