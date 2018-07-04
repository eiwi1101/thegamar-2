class Room
  extend DslBase

  attributes :name,
             :description

  containers loot_table: LootTable
end
