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

    _send_combat_result damage
  end

  private

  def _send_combat_result(result)
    subtle = "#{result.damage} damage"
    subtle += " (#{result.overkill} overkill)" if result.overkill > 0
    subtle += " (Critical!)" if result.critical?
    subtle += " (Miss)" if result.miss?
    subtle += ", Target: #{result.target.health.percent_display}"

    prompt = Prompt.new result.flavor,
                        additional: subtle.colorize(:red)

    self.send_prompt prompt
  end
end
