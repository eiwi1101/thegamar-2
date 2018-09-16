class Damage
  attr_reader :attacker,
              :target,
              :weapon,
              :weapon_damage,
              :attack_roll,
              :effective,
              :absorbed,
              :overkill,
              :damage

  def initialize(attacker, target, weapon)
    @attacker = attacker
    @target = target
    @weapon = weapon
  end

  def roll!
    raise CombatError.new("Attack already rolled.") if self.attack_roll.present?

    @attack_roll = rand(20) + 1

    _calc_weapon_damage

    _calc_absorbed
    _calc_effective
    _calc_overkill
    _calc_total
  end

  def miss?
    miss_threshold = 1
    @attack_roll <= miss_threshold
  end

  def critical?
    crit_threshold = 20
    @attack_roll >= crit_threshold
  end

  def flavor
    return "You fail." if miss?
    return "You attack super hard!" if critical?
    "You attack."
  end

  def damage_table
    {
        attack_roll: @attack_roll,
        weapon_damage: @weapon_damage,
        absorbed: @absorbed,
        effective: @effective,
        overkill: @overkill,
        total: @damage
    }
  end

  alias :to_h :damage_table
  alias :to_i :damage

  private

  def _calc_weapon_damage
    if self.miss?
      return @weapon_damage = 0
    end

    if self.weapon.nil?
      base = @attacker.stats.strength
    else
      base = @weapon.damage
    end

    if critical?
      base *= 1.5
    else
      base *= 1.0 + (0.02 * (@attack_roll - 10))
    end

    @weapon_damage = base.floor
  end

  def _calc_absorbed
    @absorbed = 0
  end

  def _calc_effective
    @effective = @weapon_damage - @absorbed
  end

  def _calc_overkill
    @overkill = [@effective - @target.health.remain, 0].max
  end

  def _calc_total
    @damage = @effective - @overkill
  end
end
