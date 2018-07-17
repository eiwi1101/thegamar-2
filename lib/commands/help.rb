C_HELP = Command.define do
  name "Help"
  description "Show this help."
  match /^(?:help|\?)(?:\s+(?<topic>.*?))?$/

  run -> (args) do
    table = Command.defined.collect do |cmd|
      [cmd.name, cmd.description]
    end

    Prompt.new "Showing help for #{args[:topic] || 'All Commands'}:", table: table
  end
end
