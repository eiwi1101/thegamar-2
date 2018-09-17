module TargetHelper
  def find_target(name)
    if name.nil?
      return self.current_target
    end

    case name.downcase
    when /^me|(my\s*)?self$/
      return self
    when /^assist$/
      return self.current_target&.current_target
    else
      raise GameError.new "I can't find #{name}."
    end
  end

  def reaction(to)
    self == to ? :friendly : :hostile
  end
end
