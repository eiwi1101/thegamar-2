class Command
  include DslBase

  attributes :name,
             :match,
             :description,
             :run,
             :aliases

  def self.parse(player, input)
    input.downcase!

    matches = defined.values.select do |command|
      command.match =~ input or command.alias? input
    end

    if matches.many?
      raise CommandError.new "Did you mean: #{matches.collect(&:name).join(', ')}", input, matches: matches
    end

    if matches.none?
      raise CommandError.new "I'm not sure what you meant.", input
    end

    matches.first.execute(player, input)
  end

  def execute(player, input)
    not_implemented if run.nil?

    matches = match.match(resolve_alias input)
    arguments = [matches.names, matches.captures].transpose.to_h.with_indifferent_access

    arguments.each { |k, v| arguments[k] = v&.strip.presence }

    perform(player, arguments)
  end

  def chain(command, player, args=nil)
    command.perform(player, args)
  end

  def alias?(input)
    aliases&.keys&.include? input.split(/\s+/).first.to_sym
  end

  def resolve_alias(input)
    return input if aliases.nil?

    input_parts = input.split(/\s+/, 2)
    base = input_parts.shift&.to_sym

    while base.is_a? Symbol and aliases.keys.include? base
      base = aliases[base]
    end

    return input if base.nil?

    input_parts.unshift base
    resolved = input_parts.join(' ')

    resolved.strip
  end

  protected

  def perform(player, args)
    if player.health.dead? and !flagged? :death
      raise CommandError.new "You are dead!", args
    end

    result = run.call(player, args)

    if result.is_a? Prompt
      player.send_prompt(result)
    end
  end
end
