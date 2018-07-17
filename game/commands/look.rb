C_LOOK = Command.define do
  name "Look"
  description "Look around you."
  match /^l(?:ook)?\b/

  run -> (_args) do
    current_room = SCARY_ROOM

    Prompt.new current_room.description
  end
end
