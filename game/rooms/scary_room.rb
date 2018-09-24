require_relative '../npcs/manager'

Room.define :SCARY_ROOM do
  name "A Scary Room"

  description <<-TEXT
    You see before you a small, concrete chamber. Dried brown bloodstains
    cover the cracked, concrete floor. It reeks of death.
  TEXT

  exits do
    north THE_FOYER
  end

  # todo containerize
  npcs [N_MANAGER]
end
