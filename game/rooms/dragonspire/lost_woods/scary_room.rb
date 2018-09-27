Room.define :SCARY_ROOM do
  name "Lost in the Woods"

  description <<-TEXT
    You find yourself lost in the woods. Once, before the humans arrived, dragons ruled this land. Now, as you look 
    around, you see only the grey shadows of thick, dead trees. The earth is silent, and the ground is covered in 
    ash. 

    A trail leads to the south. (You may type "go south" or simply "south" to follow it.)
  TEXT

  exits do
    south R_LOST_WOODS_2
  end
end
