require 'spec_helper'

describe PlayerState do
  it 'serializes' do
    PlayerState.reset
    player = PlayerState.instance
    json = player.as_json

    expect(json[:current_room]).to eq 'SCARY_ROOM'
  end

  it 'loads' do
    PlayerState.load current_room: 'THE_FOYER'
    player = PlayerState.instance
    expect(player.current_room).to eq THE_FOYER
  end
end
