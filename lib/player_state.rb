class PlayerState
  include Singleton
  include TargetHelper
  include InventoryHelper
  include CombatHelper

  attr_accessor :health
  attr_accessor :current_room
  attr_accessor :current_target

  def name
    "You"
  end

  def stats
    OpenStruct.new strength: 10,
                   intellect: 10,
                   dexterity: 10,
                   constitution: 10,
                   wisdom: 10
  end

  def self.init
    state = self.instance
    state.current_room ||= SCARY_ROOM
    state.health = Health.new(state)
  end

  def self.reset
    state = self.instance
    state.current_room = SCARY_ROOM
    state.health = Health.new(state)
  end

  def self.load(attributes)
    init
    state = self.instance
    state.current_room = Room.defined[attributes[:current_room]]
  end

  def as_json
    {
        current_room: current_room&.const
    }
  end
end
