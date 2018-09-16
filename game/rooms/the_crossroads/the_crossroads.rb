Room.define :THE_CROSSROADS do
  # zone Zone::CROSSROADS
  name "The Crossroads"

  # flags :outside, :large

  description <<-TEXT
    You stand between two white gravel roads crossing
    through a field of wildflowers. While you are unsure
    how you arrived here, you feel comfortable and safe.

    The Northern road continues to distant barren lands,
    the Eastern road continuing to a jungle. To the immediate
    south you see a large tower. The western road continues
    to a distant shack on the edge of what appears to be
    ocean.
  TEXT

  exits do
    north THE_BARREN_ROAD #, distant: true
    east THE_JUNGLE_ROAD #, distant: true
    south OUTSIDE_THE_TOWER
    west THE_OCEAN_ROAD #, distant: true
  end
end
