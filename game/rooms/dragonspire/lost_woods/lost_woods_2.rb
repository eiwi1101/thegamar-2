Room.define :R_LOST_WOODS_2 do
  # zone :LOST_WOODS

  name "Lost in the Woods"

  description <<-DESC
    You are slightly lost in the woods. The Dragonspire Woods, you recognize, were once an emerald green gem nestled
    atop the jagged Northern mountains of Dalryn. Now, all that is here is smoke and ash. Fragments of bone hang from
    pikes lashed to the dead branches of the trees around you. Trophies, from when the humans had come to hunt the
    dragons.

    The path you are on widens and continues to the east, with a narrow trail leading north.
  DESC

  exits do
    north SCARY_ROOM
    east R_LOST_WOODS_3
  end
end
