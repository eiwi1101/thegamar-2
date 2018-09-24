Command.define :C_EXAMINE do
  name "Examine"
  description "Examines items in the room, your inventory, or equipped."

  match /^(?:x|examine)\b(?:\s+(?<item>.*))?$/

  run -> (player, args) do
    item = player.find_item args[:item]

    unless item
      raise GameError.new 'Examine what?'
    end

    Prompt.new item.name.colorize(:black),
               additional: [
                   item.description
               ]
  end
end
