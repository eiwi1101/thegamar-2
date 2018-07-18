class PlayerState
  include Singleton

  attr_accessor :current_room

  def self.init
    state = self.instance
    state.current_room ||= SCARY_ROOM
  end

  def self.reset
    state = self.instance
    state.current_room = SCARY_ROOM
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
