Command.define :C_HELP do
  name "Help"
  description "Show this help."
  match /^(?:help|\?)(?:\s+(?<topic>.*?))?$/

  run -> (player, args) do
    table = Command.defined.collect do |command|
      const, cmd = command
      [cmd.name, cmd.description, cmd.flags.to_sentence.colorize(:light_black)]
    end

    Prompt.new "Showing help for #{args[:topic] || 'All Commands'}:", table: table
  end
end
