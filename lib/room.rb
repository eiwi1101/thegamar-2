class Room
  include DslBase

  attributes :name,
             :description

  containers loot_table: LootTable,
             exits: ExitMap

  def exit(direction)
    clean = _clean_direction direction
    raise "This room has no exits!" unless exits&.any?
    exits[clean]
  end

  def exits_to?(direction)
    !exit(direction).nil?
  end

  private

  def _clean_direction(direction)
    direction_alias = {
        n: :north,
        e: :east,
        s: :south,
        w: :west,
        u: :up,
        d: :down
    }

    dsym = direction.downcase.to_sym
    result = direction_alias[dsym] || dsym

    if direction_alias.values.include? result
      result
    else
      raise "I don't know how to go #{direction}."
    end
  end
end
