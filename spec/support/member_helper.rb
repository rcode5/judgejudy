module MemberHelper

  # Member data is stored in a class array so we really need to clean it
  # out between tests
  # NOTE: Tried class_variable_set :@@all but that didn't seem to take
  def reset_member_class
    begin
      Pardner.send(:remove_const, :Member)
    rescue
    end
    load "pardner/models/member.rb"
  end
end

RSpec.configure do |config|
  config.include MemberHelper, type: :bot
  config.after(:each, type: :bot) { reset_member_class }
end
