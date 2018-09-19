class Stats
  VALID_STATS = [
      :strength,
      :dexterity,
      :intellect,
      :constitution,
      :wisdom,
      :charisma
  ]

  VALID_STATS.each { |s| attr_reader s }

  def initialize(stats = {})
    VALID_STATS.each do |stat|
      value = stats[stat] || 10
      instance_variable_set "@#{stat}", value
    end
  end

  def get(stat)
    stat = stat.downcase.to_sym
    raise ArgumentError.new "'#{stat}' is not a valid stat." unless VALID_STATS.include? stat
    self.send(stat)
  end

  alias :[] :get

  def to_h
    VALID_STATS.collect do |stat|
      [stat, self[stat]]
    end.to_h
  end
end
