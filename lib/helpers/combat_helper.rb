module CombatHelper
  def attack(target, with: nil)
    unless !with or with.weapon?
      raise CombatError.new "#{with.name} is not a weapon!"
    end

    if target.health.dead?
      raise CombatError.new "#{target.name} is dead!"
    end

    damage = Damage.new self, target, with
    damage.roll!

    target.health << damage
    damage
  end
end
