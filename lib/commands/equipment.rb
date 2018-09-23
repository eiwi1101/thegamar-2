Command.define :C_EQUIPMENT do
  name "Equipment"
  description "Shows what you are wearing."
  match /^e(?:quip(?:ment)?)?\b\s*(?<item>.*)?/i

  run -> (player, _args) do
    equipment_table = []

    Item::Equipment::SLOTS.each do |slot, data|
      equipment_table << [data[:name], player.equipment[slot]&.colorized_name || "<naked>".colorize(:light_black)]
    end

    Prompt.new "You are wearing:",
               table: equipment_table
  end
end
