require_relative '../stats'

class Item::Equipment < Item
  SLOTS = {
      neck: {
          name: "Neck"
      },
      main_hand: {
          name: "Main Hand"
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
