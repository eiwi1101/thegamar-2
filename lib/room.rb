class Room
  include DslBase

  attributes :name,
             :description

  containers loot_table: LootTable,
             exits: ExitMap

  def exit(direction)
    raise "This room has no exits!" unless exits&.any?
    clean = exits.clean_direction direction
    exits[clean]
  end

  def exits_to?(direction)
    !exit(direction).nil?
  end
end
