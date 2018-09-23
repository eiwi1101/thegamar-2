Item::Weapon.define :I_WINE_GLASS do
  name "Wine Glass"

  description <<-TEXT
    A simple wine glass, gently tapered, with
    a wide body and long, narrow stem.
  TEXT

  damage intellect: 10

  combat_text do
    hit "Years of drinking never prepared you for this."
    critical "Aaahhh... A third year blue, certain elves would appreciate this."
    miss "Looks like your cup is empty, friend."
  end
end
