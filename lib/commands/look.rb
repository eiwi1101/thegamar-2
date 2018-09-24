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

    additional = [
        current_room.description
    ]

    current_room.npcs&.each do |npc|
      color = npc.reaction_color(player)
      additional.push "#{npc.name} is here.".colorize(color)
    end

    Prompt.new current_room.name.colorize(:black),
               additional: additional
  end
end
