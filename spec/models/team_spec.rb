require 'spec_helper'

describe Pardner::Team do
  let(:team) { described_class.create(name: 'Super', members: ['jill@example.com', 'bill@example.com']) }

  describe '#member?' do
    it 'is true if the given email is a member of the team' do
      expect(team.member?('jill@example.com')).to eql true
    end
    it 'is false if the given email is not a member of the team' do
      expect(team.member?('illj@example.com')).to eql false
    end
  end

  describe "validations" do
    it "is invalid without name" do
      t = described_class.new
      t.valid?
      expect(t).not_to be_valid
      expect(t.errors[:name]).to be_present
    end

    it "is invalid without a unique name" do
      team
      t = described_class.new(name: team.name)
      t.valid?
      expect(t).not_to be_valid
      expect(t.errors[:name]).to be_present
    end

    it "is valid with a name" do
      expect(described_class.new(name: 'my team')).to be_valid
    end

  end


end
