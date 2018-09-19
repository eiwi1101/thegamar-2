Command.define :C_ATTACK do
  name "Attack"
  description "Attack with your weapon, or flail unarmed."
  match /^attack(?<target>\s+(?!with).*?)?(?:\s+with\s+(?<weapon>.*?))?$/i

  run -> (player, args) do
    target = player.find_target args[:target]
    weapon = player.find_item args[:weapon]

    if target.nil?
      raise CombatError.new "You need a target!"
    end

    player.attack target, with: weapon
  end
end
