Command.define :C_LOOK do
  name "Look"
  description "Look around you."
  match /^l(?:ook)?\b/

  flags :death

  run -> (player, _args) do
    current_room = player.current_room

    if current_room.nil?
      raise "You are not in any room!"
    end

    Prompt.new current_room.name.colorize(:black),
               additional: [
                   current_room.description
               ]
  end
end
