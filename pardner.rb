require 'slack-ruby-bot'
require_relative 'pardner/hooks/hello'

Dir['pardner/models/**/*.rb'].each { |f| require_relative f }
Dir['pardner/commands/**/*.rb'].each { |f| require_relative f }
Dir['pardner/services/**/*.rb'].each { |f| require_relative f }
require_relative 'pardner/bot'
