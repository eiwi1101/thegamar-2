require_relative './stats'

class Player
  include TargetHelper
  include InventoryHelper
  include CombatHelper

  attr_accessor :current_room,
                :current_target

  attr_reader :stats,
              :health,
              :name

  def initialize(data = {})
    @name = data[:name] || "Anonymous"
    @current_room = Room.lookup(data[:current_room]) || SCARY_ROOM
    @stats = Stats.new data[:stats] || {}, default: 10
    @health = Health.new self, data[:health_depleted] || 0
  end

  def equipment
    OpenStruct.new main_hand: I_RUSTY_KNIFE,
                   neck: I_FRAGMENT_OF_EGG
  end

  def inventory
    [
        OpenStruct.new(quantity: 3,
                       item: I_WINE_GLASS)
    ]
  end

  def stats
    base = @stats.reset!
    equipment.to_h.each do |_slot, item|
      base += item.stats
    end
    base
  end

  def on_prompt(&proc)
    @on_prompt ||= []
    @on_prompt << proc
    self
  end

  def send_prompt(prompt)
    @on_prompt&.each do |handler|
      handler.call(prompt)
    end
    self
  end

  def to_h
    {
        name: @name,
        current_room: @current_room.const,
        stats: @stats.to_h,
        health_depleted: @health.damage
    }
  end

  def to_s
    "#<%s:%x '%s'>" % [
        self.class.name,
        self.object_id,
        @name
    ]
  end

  alias :inspect :to_s

  alias :as_json :to_h
end
