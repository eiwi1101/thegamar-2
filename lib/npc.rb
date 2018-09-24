require_relative './stats'

class Npc
  include DslBase
  include CombatHelper

  REACTIONS = {
      friendly: {
          color: :light_green
      },
      neutral: {
          color: :light_yellow
      },
      hostile: {
          color: :light_red
      }
  }

  attr_reader :health

  attributes :name,
             :description,
             :level,
             :current_room,
             :current_target

  container :stats, Stats, container: [{ default: 10 }]

  def post_initialize
    @health = Health.new self
  end

  def reaction(target)
    :friendly
  end

  def reaction_color(target)
    REACTIONS[reaction(target)][:color]
  end
end
