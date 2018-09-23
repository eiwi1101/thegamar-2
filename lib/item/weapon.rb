class Item::Weapon < Item
  attributes :damage

  container :combat_text, CombatText, required: true

  def weapon?
    true
  end
end
