require 'spec_helper'

describe C_MOVE do
  let(:player) { PlayerState.instance }
  let(:input) { 'move north' }

  subject { C_MOVE }

  before(:each) { PlayerState.reset }

  describe '#execute' do
    subject { C_MOVE.execute input }

    it { expect { subject }.to change { player.current_room } }

    describe 'aliases' do
      let(:input) { |example| example.metadata[:description] }

      it('move n') { expect { subject }.to change { player.current_room } }
      it('go north') { expect { subject }.to change { player.current_room } }
      it('north') { expect { subject }.to change { player.current_room } }
      it('n') { expect { subject }.to change { player.current_room } }
    end
  end
end
