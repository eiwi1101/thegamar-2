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
      target_scope = self.current_room.npcs || []

      matches = target_scope.select { |item| item.name =~ /#{Regexp.escape(name)}/i }

      if matches.empty?
        raise GameError.new "I can't find #{name}."
      elsif matches.many?
        options = matches.collect(&:name).to_sentence(two_words_connector: ' or ', last_word_connector: ', or ')
        raise GameError.new "Did you mean: #{options}?"
      else
        matches.first
      end
    end
  end

  def reaction(to)
    self == to ? :friendly : :hostile
  end
end
