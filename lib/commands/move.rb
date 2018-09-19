require_relative '../containers/exit_map'

Command.define :C_MOVE do
  name "Move"
  description "Move in any particular direction."
  match /^(m(?:ove)?|go)(?:\s+(?<direction>.*?))?$/

  movement_aliases = ExitMap::DIRECTIONS.collect { |d| [d, "move #{d}"] }.to_h

  aliases movement_aliases.merge ExitMap::DIRECTION_ALIAS

  run -> (player, args) do
    unless args[:direction]
      raise MovementError.new "You should specify a direction."
    end

    unless player.current_room
      raise MovementError.new "You are not in a room."
    end

    unless player.current_room.exits_to? args[:direction]
      raise MovementError.new "You can't go #{args[:direction]}!"
    end

    new_room = player.current_room.exit args[:direction]

    player.current_room = new_room

    chain C_LOOK, player
  end
end
