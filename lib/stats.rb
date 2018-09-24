class Stats
  VALID_STATS = [
      :strength,
      :dexterity,
      :intellect,
      :constitution,
      :wisdom,
      :charisma
  ]

  VALID_STATS.each do |stat|
    define_method stat do |value=nil|
      if value.nil?
        get stat
      else
        set stat, value
      end
    end
  end

  def initialize(stats = {}, options = {})
    @modifiers = {}
    default = options.delete(:default) || stats.delete(:default) || 0

    VALID_STATS.each do |stat|
      value = stats[stat] || default
      @modifiers[stat] = 0
      set stat, value
    end
  end

  def get(stat)
    base = instance_variable_get _var(stat)
    base + @modifiers[stat] || 0
  end

  def set(stat, value)
    instance_variable_set _var(stat), value
  end

  alias :[] :get
  alias :[]= :set

  def +(other_stat)
    return self if other_stat.nil?
    VALID_STATS.each do |stat|
      @modifiers[stat] += other_stat.get(stat)
    end
    self
  end

  def reset!
    VALID_STATS.each { |s| @modifiers[s] = 0 }
    self
  end

  def to_h
    VALID_STATS.collect do |stat|
      [stat, self[stat]]
    end.to_h.merge(modifiers: @modifiers)
  end

  private

  def _var(stat)
    stat = stat.downcase.to_sym
    raise ArgumentError.new "'#{stat}' is not a valid stat." unless VALID_STATS.include? stat
    "@#{stat}"
  end
end
