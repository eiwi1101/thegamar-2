require_relative '../../lib/stats'
require 'spec_helper'

describe Stats do
  it 'accepts values' do
    s = Stats.new strength: 20
    expect(s.strength).to eq 20
    expect(s[:strength]).to eq 20
    expect(s.get('strength')).to eq 20
  end

  it 'assigns defaults' do
    s = Stats.new({}, default: 10)
    expect(s.wisdom).to eq 10
  end

  describe '#get' do
    it 'fails on invalid args' do
      s = Stats.new
      expect { s.get('taco bell') }.to raise_error(ArgumentError)
    end
  end

  describe '#to_h' do
    it 'serializes' do
      s = Stats.new({}, default: 10)
      expect(s.to_h).to include strength: 10
    end

    it 'loads' do
      s1 = Stats.new wisdom: 13
      s2 = Stats.new s1.to_h
      expect(s2.wisdom).to eq 13
    end
  end
end
