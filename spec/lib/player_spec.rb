require 'spec_helper'

describe Player do
  it 'serializes' do
    player = Player.new
    json = player.as_json

    expect(json[:current_room]).to eq 'SCARY_ROOM'
  end

  it 'loads' do
    player = Player.new current_room: 'THE_FOYER'
    expect(player.current_room).to eq THE_FOYER
  end
end
