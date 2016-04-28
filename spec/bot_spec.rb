require 'spec_helper'

describe 'Pardner Bot' do
  subject(:pardner) { Pardner::Bot.instance }

  it_should_behave_like 'a slack ruby bot'


end