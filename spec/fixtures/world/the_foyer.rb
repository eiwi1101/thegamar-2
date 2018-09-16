Room.define :THE_FOYER do
  name "The Foyer"

  description <<-TEXT
    You find yourself standing in a large foyer, a fireplace
    crackles softly in the corner. Crumbling plaster reveals
    a pathway to the south.
  TEXT

  exits do
    south SCARY_ROOM
  end
end
