require 'spec_helper'

describe C_ATTACK, type: :command do
  subject { described_class }

  describe '#execute' do
    describe 'parsing' do
      it { expect_args 'attack', target: nil, weapon: nil }
      it { expect_args 'attack couch', target: 'couch', weapon: nil }
      it { expect_args 'attack with taco', target: nil, weapon: 'taco'}
      it { expect_args 'attack couch with taco', target: 'couch', weapon: 'taco' }
    end
  end
end
