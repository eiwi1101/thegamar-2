Command.define :C_ATTACK do
  name "Attack"
  description "Attack with your weapon, or flail unarmed."
  match /^attack(?<target>\s+(?!with).*?)?(?:\s+with\s+(?<weapon>.*?))?$/i

  run -> (args) do
    target = player.find_target args[:target]
    weapon = player.find_item args[:weapon]

    if target.nil?
      raise CombatError.new "You need a target!"
    end

    result = player.attack target, with: weapon

    subtle = "#{result.damage} damage"
    subtle += " (#{result.overkill} overkill)" if result.overkill > 0
    subtle += " (Critical!)" if result.critical?
    subtle += " (Miss)" if result.miss?
    subtle += ", Target: #{target.health.percent_display}"

    Prompt.new result.flavor,
               additional: subtle.colorize(:red)
  end
end
