Command.define :C_REVIVE do
  name "Revive"
  description "TEST - Bring yourself back to life."
  match /^revive\b/

  run -> (player, _args) do
    player.health.reset!

    narrate = [
        "Woah, that was quite the dream...",
        "Life returns. For now.",
        "Some mighty adventurer you are.",
        "Did somebody forget to put on armor?",
        "You can't keep doing this forever, you know.",
        "If only it were this easy."
    ].sample

    Prompt.new narrate
  end
end
