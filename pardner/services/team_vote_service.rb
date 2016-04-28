module Pardner
  module Services
    class TeamVoteService

      def self.tally_morale
        scores = Team.all.inject({}) do |memo, team|
          scores = []
          team.votes.each do |vote|
            scores << vote if team.member? vote.member_email
          end
          len = (scores.length > 0 ? scores.length : 1)
          memo[team.name] = scores.map(&:score).sum.to_f/len.to_f
          memo
        end.sort_by { |team, score| -score }
        Hash[scores]
      end

      def self.tally_score
        scores = Team.all.inject({}) do |memo, team|
          scores = []
          team.votes.each do |vote|
            scores << vote unless team.member? vote.member_email
          end
          len = (scores.length > 0 ? scores.length : 1)
          memo[team.name] = scores.map(&:score).sum.to_f/len.to_f
          memo
        end.sort_by { |team, score| -score }
        Hash[scores]
      end

    end
  end
end
