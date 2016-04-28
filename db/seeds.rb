require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require_relative '../pardner/models/team'

teams = [
  {
    name:'Team 1',
    members: [
      'matt@carbonfive.com',
      'christian@carbonfive.com',
      'ingar@carbonfive.com',
      'yasmine@carbonfive.com',
      'achan@carbonfive.com',
      'katie@carbonfive.com',
      'chris@carbonfive.com'
    ]
  },
  {
    name: 'Team 2',
    members: [
      'ryanf@carbonfive.com',
      'erik@carbonfive.com',
      'nicole@carbonfive.com',
      'francesca@carbonfive.com',
      'zoe@carbonfive.com',
      'clark@carbonfive.com',
      'nate@carbonfive.com'
    ]
  },
  {
    name: 'Team 3',
    members: [
      'janet@carbonfive.com',
      'sam@carbonfive.com',
      'mike@carbonfive.com',
      'annu@carbonfive.com',
      'marc@carbonfive.com',
      'craig@carbonfive.com',
      'sean@carbonfive.com'
    ]
  },
  {
    name: 'Team 4',
    members: [
      'allie@carbonfive.com',
      'rob@carbonfive.com',
      'elias@carbonfive.com',
      'adaniel@carbonfive.com',
      'gregb@carbonfive.com',
      'brandy@carbonfive.com',
      'shannon@carbonfive.com'
    ]
  },
  {
    name: 'Team 5',
    members: [
      'virginia@carbonfive.com',
      'alex@carbonfive.com',
      'rae@carbonfive.com',
      'kelsey@carbonfive.com',
      'erici@carbonfive.com',
      'brian@carbonfive.com',
      'anna@carbonfive.com',
      'jaythan@carbonfive.com'
    ]
  },
  {
    name: 'Team 6',
    members: [
      'kristin@carbonfive.com',
      'rudy@carbonfive.com',
      'laura@carbonfive.com',
      'courtney@carbonfive.com',
      'greg@carbonfive.com',
      'dan@carbonfive.com',
      'lilei@carbonfive.com',
      'amanda@carbonfive.com'
    ]
  },
  {
    name: 'Team 7',
    members: [
      'audrey@carbonfive.com',
      'ken@carbonfive.com',
      'david@carbonfive.com',
      'justin@carbonfive.com',
      'andrew@carbonfive.com',
      'chrisk@carbonfive.com',
      'mavila@carbonfive.com'
    ]
  },
  {
    name: 'Team 8',
    members: [
      'suzanna@carbonfive.com',
      'don@carbonfive.com',
      'jon@carbonfive.com',
      'bobby@carbonfive.com',
      'sueanna@carbonfive.com',
      'ericf@carbonfive.com',
      'sidney@carbonfive.com'
    ]
  }

]

teams.each do |t|
  team = Pardner::Team.find_by(name: t[:name])
  Pardner::Team.create!(t) unless team
end

puts "We've got #{Pardner::Team.count} teams"
