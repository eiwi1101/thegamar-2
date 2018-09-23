class Item
  include DslBase

  QUALITIES = {
      useless: {
          name: "Useless",
          color: :gray
      },
      common: {
          name: "Common",
          color: :white
      },
      uncommon: {
          name: "Uncommon",
          color: :green
      },
      rare: {
          name: "Rare",
          color: :blue
      },
      epic: {
          name: "Epic",
          color: :purple
      },
      legendary: {
          name: "Legendary",
          color: :orange
      },
      broken: {
          name: "Broken",
          color: :red
      }
  }.freeze

  attributes :name,
             :description,
             :stack_count,
             :unique_count,
             :value,
             :quality

  validates :name, presence: :true
  validates :description, presence: :true
  validates :stack_count, numericality: { min: 1, allow_nil: true }
  validates :unique_count, numericality: { min: 1, allow_nil: true }
  validates :value, numericality: { min: 0, allow_nil: true }
  validates :quality, inclusion: { in: QUALITIES.keys }, default: :useless


  def weapon?
    false
  end

  def equipment?
    false
  end
end
