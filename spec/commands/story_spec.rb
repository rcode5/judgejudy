require 'spec_helper'

describe Pardner::Commands::Story, type: :bot do
  [ "What's your story, pardner",
    "whats yer story pardner",
    "whats your story pardner?"].each do |msg|
    it "responds to '#{msg}' with the the background story" do
      expect(message: msg).to respond_with_slack_message(/Glad you asked/)
    end
  end

  context "when pardner is called out by name" do
    it "responds to `@pardner what's your story` with the the background story" do
      expect(message: "#{SlackRubyBot.config.user} what's your story").to respond_with_slack_message(/Glad you asked/)
    end


  end
end