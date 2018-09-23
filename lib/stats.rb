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
        get(stat)
      else
        instance_variable_set "@#{stat}", value
      end
    end
  end

  def initialize(stats = {}, options = {})
    @modifiers = {}
    default = options.delete(:default) || stats.delete(:default) || 0

    VALID_STATS.each do |stat|
      value = stats[stat] || default
      @modifiers[stat] = 0
      instance_variable_set "@#{stat}", value
    end
  end

  def get(stat)
    stat = stat.downcase.to_sym
    raise ArgumentError.new "'#{stat}' is not a valid stat." unless VALID_STATS.include? stat
    base = instance_variable_get "@#{stat}"
    modified = base + @modifiers[stat] || 0
  end

  alias :[] :get

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
end
