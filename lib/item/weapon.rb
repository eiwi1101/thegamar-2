class Item::Weapon < Item
  attributes :damage

  container :combat_text, CombatText

  def weapon?
    true
  end
end
