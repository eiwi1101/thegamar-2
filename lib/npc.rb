require 'stats'

class Npc
  include DslBase
  include CombatHelper

  attr_reader :health

  attributes :name,
             :description,
             :level,
             :current_room,
             :current_target

  container :stats, Stats, default: 10

  def post_initialize
    @health = Health.new self
  end
end
