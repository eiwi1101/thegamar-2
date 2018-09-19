Command.define :C_INVENTORY do
  name "Inventory"
  description "Shows what you are carrying."
  match /^i(?:nv(?:entory)?)?\b/i

  run -> (player, _args) do
    if player.inventory.empty?
      Prompt.new "You are empty handed."
    else
      inventory_table = player.inventory.collect do |item|
        ["%dx" % [item.quantity], item.item.name || "?"]
      end

      Prompt.new "You are carrying:",
                 table: inventory_table
    end
  end
end
