require 'spec_helper'

describe Item do
  describe 'validations' do
    Item.define :I_BROKEN do
    end

    Item::Weapon.define :I_WEAPON do
      name "Stabber"
      description "Stabber"
    end

    Item::Weapon.define :I_NEVER_MISS do
      name "Nevermiss"
      description "Nevermiss"

      combat_text do
      end
    end

    it 'validates broken' do
      i = I_BROKEN
      expect(i).to_not be_valid
      expect(i.errors.count).to be > 0
    end

    it 'validates valid' do
      i = I_BASIC
      expect(i).to be_valid
      expect(i.quality).to eq :useless
    end

    it 'validates association required' do
      i = I_WEAPON
      expect(i.quality).to eq :useless
      expect(i).to_not be_valid
      expect(i.errors.count).to eq 3
      expect(i.errors[:combat_text].count).to be > 0
    end

    it 'validates association' do
      i = I_NEVER_MISS
      expect(i).to_not be_valid
      expect(i.combat_text.errors.count).to eq 3
    end

    it 'validates all' do
      expect(Item.validate_all!).to eq false
    end
  end
end
