module Pardner
  class Vote < ActiveRecord::Base

    validates :member_email, presence: true
    validates :team_id, presence: true, uniqueness: { :scope => :member_email  }
    validate :validate_team
    validates_presence_of :score, message: 'You gotta gimme a score.'
    validates_numericality_of :score,
                              message: 'That score belongs in a spitoon.  It should be between 0 and 5',
                              only_integer: true,
                              greater_than_or_equal_to: 0,
                              less_than: 6

    belongs_to :team

    def validate_team
      errors.add(:team, "Whoa, Nelly.  That team is not on *this* prairie.") unless Pardner::Team.find_by(id: team_id)
    end
  end
end
