teams = Pardner::Team.all

puts "Adding a couple votes"

# score votes
Pardner::Vote.create team: teams.first, score: 1, member_email: teams.last.members.last
Pardner::Vote.create team: teams.last, score: 3, member_email: teams.first.members.last
Pardner::Vote.create team: teams.last, score: 5, member_email: teams.first.members.first

# morale votes - vote for your own team
Pardner::Vote.create team: teams.last, score: 5, member_email: teams.last.members.first
