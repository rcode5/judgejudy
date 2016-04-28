require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require './environments'

module Pardner
  class Web < Sinatra::Base
    get '/' do
      @scores = Pardner::Services::TeamVoteService.tally_score
      @morales = Pardner::Services::TeamVoteService.tally_morale
      slim :leaderboard
    end
  end
end
