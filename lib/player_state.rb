class PlayerState
  include Singleton

  attr_accessor :current_room

  def self.init
    state = self.instance
    state.current_room ||= SCARY_ROOM
  end

  def _dump(depth)
    Marshal.dump(@current_room, depth)
  end
end
