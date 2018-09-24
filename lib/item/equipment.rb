require_relative '../stats'

class Item::Equipment < Item
  SLOTS = {
      head: {
          name: "Head"
      },
      neck: {
          name: "Neck"
      },
      chest: {
          name: "Chest"
      },
      hands: {
          name: "Hands"
      },
      waist: {
          name: "Waist"
      },
      legs: {
          name: "Legs"
      },
      feet: {
          name: "Feet"
      },
      main_hand: {
          name: "Main Hand"
      },
      accessory: {
          name: "Accessory"
      }
  }

  attributes :slot,
             :level

  container :stats, Stats

  validates :slot, inclusion: { in: SLOTS.keys }
  validates :level, numericality: { min: 1 }, default: 1

  def equipment?
    true
  end
end
