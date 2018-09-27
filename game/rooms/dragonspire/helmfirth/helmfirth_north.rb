Room.define :R_HELMFIRTH_NORTH do
  name "North of Helmfirth"

  description <<-DESC
    The sound of running water from the creek below greets you as you approach a small wooden bridge. New grass grows
    around the water, but beyond that the land is barren. A northern path leads toward the dark border of the once
    great Dragonspire Forest.

    A cobblestone path continues south of the bridge, toward Helmfirth. The black, iron gate sits open and the smell of
    firewood burning fills the air. Green vines crawl up over crumbling walls around the village.

    [Developer note: This is as far as I got tonight. The story will continue...]
  DESC

  exits do
    north R_LOST_WOODS_EDGE
    # south R_HELMFIRTH_GATE
  end
end
