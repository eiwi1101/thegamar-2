Command.define :C_HELP do
  name "Help"
  description "Show this help."
  match /^(?:help|\?)(?:\s+(?<topic>.*?))?$/

  run -> (args) do
    table = Command.defined.collect do |command|
      const, cmd = command
      [cmd.name, cmd.description]
    end

    Prompt.new "Showing help for #{args[:topic] || 'All Commands'}:", table: table
  end
end
