class Player
  include TargetHelper
  include InventoryHelper
  include CombatHelper

  attr_accessor :current_room,
                :current_target

  attr_reader :stats,
              :health

  def initialize(data = {})
    @name = data[:name] || "Anonymous"
    @current_room = Room.lookup(data[:current_room]) || SCARY_ROOM
    @stats = Stats.new data[:stats] || {}
    @health = Health.new self, data[:health_depleted] || 0
  end

  def equipment
    OpenStruct.new main_hand: I_RUSTY_KNIFE
  end

  def inventory
    [
        OpenStruct.new(quantity: 3,
                       item: I_WINE_GLASS)
    ]
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

  def to_str
    "#<%s:%x '%s'>" % [
        self.class.name,
        self.object_id,
        @name
    ]
  end

  alias :as_json :to_h
end
