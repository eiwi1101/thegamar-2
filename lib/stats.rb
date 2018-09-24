class Stats
  VALID_STATS = [
      :strength,
      :dexterity,
      :intellect,
      :constitution,
      :wisdom,
      :charisma
  ]

  def initialize(stats = {})
    VALID_STATS.each do |stat|
      value = stats[stat] || 10
      set stat, value
    end
  end

  def get(stat)
    instance_variable_get _var(stat)
  end

  def set(stat, value)
    instance_variable_set _var(stat), value
  end

  alias :[] :get
  alias :[]= :set

  VALID_STATS.each do |stat|
    define_method stat do |value=nil|
      if value.nil?
        get(stat)
      else
        set(stat, value)
      end
    end
  end

  def to_h
    VALID_STATS.collect do |stat|
      [stat, self[stat]]
    end.to_h
  end

  private

  def _var(stat)
    stat = stat.downcase.to_sym
    raise ArgumentError.new "'#{stat}' is not a valid stat." unless VALID_STATS.include? stat
    "@#{stat}"
  end
end
