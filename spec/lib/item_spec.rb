require 'spec_helper'

describe Item do
  Item.define :I_BROKEN do
  end

  it 'validates broken' do
    i = I_BROKEN
    expect(i.errors.count).to be > 0
  end

  it 'validates valid' do
    i = I_BASIC
    expect(i).to be_valid
    expect(i.quality).to eq :useless
  end
end
