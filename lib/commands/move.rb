Command.define :C_MOVE do
  name "Move"
  description "Move in any particular direction."
  match /^(m(?:ove)?|go)(?:\s+(?<direction>.*?))?$/

  run -> (args) do
    unless args[:direction]
      raise "You should specify a direction."
    end

    unless player.current_room
      raise "You are not in a room."
    end

    unless player.current_room.exits_to? args[:direction]
      raise "You can't go #{args[:direction]}!"
    end

    new_room = player.current_room.exit args[:direction]

    player.current_room = new_room

    chain C_LOOK
  end
end
