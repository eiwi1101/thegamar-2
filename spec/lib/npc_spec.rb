require 'spec_helper'

describe Npc do
  describe 'instance' do
    it 'recycles stats as container' do
      npc = N_MANAGER
      expect(npc.stats.strength).to eq 10
      expect(npc.stats.wisdom).to eq 19
    end

    it 'has health' do
      npc = N_MANAGER
      expect(npc.health).to be_alive
    end
  end
end
