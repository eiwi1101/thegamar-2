class Room
  include DslBase

  attributes :name,
             :description

  containers loot_table: LootTable
end
