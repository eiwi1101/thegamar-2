Room.define :R_LOST_WOODS_3 do
  name "Lost in the Woods"

  description <<-DESC
    The woods are thick here, and oddly quiet. Not many go down this path anymore, for fear of what creatures lie within
    these trees. The humans tell tales of the Dragonspire Elves to instill fear among their people, but around you lies
    not monsters, but human weapons and the last of the dragons. This land was burned by their magic, and the elves that
    lived here seek only to heal it.

    A narrow path leads west into the woods, and to the south a dim light filters through the trees.
  DESC

  exits do
    west R_LOST_WOODS_2
    south R_LOST_WOODS_EDGE
  end
end
