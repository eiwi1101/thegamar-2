Item::Equipment.define :I_FRAGMENT_OF_EGG do
  name "Dragon's Egg Fragment"

  description <<-DESC
    A pendant containing a shimmering blue and gold fravment of the cracked shell of the last Dragon's egg. This is why
    we are fighting, adventurer. Never forget that.
  DESC

  slot :neck
  quality :rare

  stats do
    wisdom +3
    strength +3
  end
end
