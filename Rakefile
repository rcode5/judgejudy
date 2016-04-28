require './web'
require 'sinatra/activerecord/rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new do
    ENV['RACK_ENV'] = 'test'
  end
rescue LoadError
  puts "rspec not available"
end

task default: :spec

namespace :db do

  task :sample_data do
    require_relative 'pardner.rb'
    require_relative 'db/sample_data'
  end

end
