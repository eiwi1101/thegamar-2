class Health

  attr_reader :base,
              :modifiers,
              :damage

  def initialize(player, damage = 0)
    @player = player
    @base = player.stats.constitution * 10
    @modifiers = 0
    @damage = damage
  end

  def total
    @base + @modifiers
  end

  def remain
    [total - @damage, 0].max
  end

  def percent
    remain.to_f / total
  end

  def percent_display
    "%d%%" % [ percent * 100 ]
  end

  def alive?
    remain > 0
  end

  def dead?
    !alive?
  end

  def take_damage(damage)
    base = @damage + damage.to_i
    @damage = [base, total].min
  end

  def reset!
    @damage = 0
  end

  alias :<< :take_damage

  def health_table
    {
        total: total,
        remain: remain,
        alive: alive?
    }
  end

  alias :to_h :health_table
end
