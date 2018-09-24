Command.define :C_STATS do
  name "Stats"
  description "Displays your combat stats."
  match /^stats\b/

  run -> (player, _args) do
    stats = player.stats.to_h
    modifiers = stats.delete(:modifiers)
    table = {}

    stats.each do |k, v|
      mod =  modifiers[k]

      modstr = if mod > 0
                 " (+#{mod})".colorize(:green)
               elsif mod < 0
                 " (#{mod})".colorize(:red)
               else
                 ""
               end

      str = v.to_s + modstr

      table[k.to_s.humanize] = str
    end

    Prompt.new "Your combat stats are:",
               table: table
  end
end
