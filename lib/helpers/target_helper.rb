module TargetHelper
  def find_target(name)
    if name.nil?
      return self.current_target
    end

    return self
    raise GameError.new "I can't find #{name}."
  end
end
