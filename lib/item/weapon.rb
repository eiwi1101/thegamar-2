class Item::Weapon < Item::Equipment
  attributes :damage

  container :combat_text, CombatText, required: true

  validates :damage, default: 0

  def weapon?
    true
  end
end
