require "spec_helper"

describe Pardner::Member do

  it "knows a few slack handles" do
    expect(Pardner::Member.slack_name('ryanf@carbonfive.com')).to eql '@ryan'
  end

  it "knows the member's slack handles" do
    member = Hashie::Mash.new( profile: { email: 'suzanna@carbonfive.com' } )
    expect(Pardner::Member.new( member ).slack_name).to eql '@suzanna'
  end
end
