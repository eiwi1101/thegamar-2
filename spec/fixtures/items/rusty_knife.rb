Item::Weapon.define :I_RUSTY_KNIFE do
  name "Rusty Knife"
  description "Weathered and rusty, but it'll still stab someone."

  damage strength: 6

  combat_text do
    hit "You stab your target."
    critical "You stab your target pretty hard."
    miss "Your knife misses your target."
  end
end
