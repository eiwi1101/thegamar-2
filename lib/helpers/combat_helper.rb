module CombatHelper
  def attack(target, with: nil)
    if target.health.dead?
      raise CombatError.new "#{target.name} is dead!"
    end

    if with.nil?
      with = self.equipment.main_hand
    end

    damage = Damage.new self, target, with
    damage.roll!

    target.health << damage
    damage
  end
end
