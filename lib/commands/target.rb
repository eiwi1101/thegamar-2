Command.define :C_TARGET do
  name "Target"
  description "Set a unit as your default target."
  match /^t(?:ar(?:get)?)?\s+(?<target>.*)$/

  flags :death

  run -> (args) do
    if args[:target].blank?
      target = player.current_target

      if target.nil?
        return Prompt.new "You have no target."
      else
        return Prompt.new "Target: #{target.name}", table: target.health.to_h
      end
    elsif args[:target] =~ /^clear|nothing|nobody$/
      target = nil
    else
      target = player.find_target args[:target]
    end

    player.current_target = target

    if target.nil?
      Prompt.new "Default target cleared."
    else
      Prompt.new "#{target.name} (#{target.reaction(player)}) is now your default target."
    end
  end
end
