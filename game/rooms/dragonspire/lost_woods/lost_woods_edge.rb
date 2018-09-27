Room.define :R_LOST_WOODS_EDGE do
  name "Edge of the Woods"

  description <<-DESC
    You stand among once-thriving saplings and smaller trees, now black and grey husks giving way to a darker forest
    beyond. Spears and pikes hang from the trees above, and from them the bones of dragons, strung together like
    marionettes, mocking the ancient and noble caretakers of this once beautiful land. A space between trees makes for 
    an almost walkable path to the north.

    To the south you can see the faint glow of a small village. A relatively safe looking dirt path gives way to 
    cobblestone.
  DESC

  exits do
    north R_LOST_WOODS_3
    south R_HELMFIRTH_NORTH
  end
end
