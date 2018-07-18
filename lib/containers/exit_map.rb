class ExitMap
  include DslBase

  DIRECTIONS = [
      :north,
      :east,
      :south,
      :west,
      :up,
      :down
  ]

  DIRECTION_ALIAS = {
      n: :north,
      e: :east,
      s: :south,
      w: :west,
      u: :up,
      d: :down
  }

  attributes *DIRECTIONS

  def clean_direction(direction)
    dsym = direction.downcase.to_sym
    result = DIRECTION_ALIAS[dsym] || dsym

    if DIRECTIONS.include? result
      result
    else
      raise MovementError.new "I don't know how to go #{direction}."
    end
  end
end
