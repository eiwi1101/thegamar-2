C_SAVE = Command.define do
  name "Save"
  description "Save your current game state."
  match /^s(?:ave)?\b/

  run -> (_args) do
    puts Marshal.dump(player)

    Prompt.new("Game saved.")
  end
end
