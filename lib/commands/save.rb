Command.define :C_SAVE do
  name "Save"
  description "Save your current game state."
  match /^s(?:ave)?\b/

  flags :death

  run -> (_args) do
    puts player.as_json

    Prompt.new("Game saved.")
  end
end
