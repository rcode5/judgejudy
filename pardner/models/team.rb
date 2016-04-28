module Pardner
  class Team < ActiveRecord::Base

    validates :name, uniqueness: true, presence: true
    has_many :votes

    def member? email
      members.include? email
    end

  end
end
