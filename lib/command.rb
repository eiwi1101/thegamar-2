class Command
  include DslBase

  attributes :name,
             :match,
             :description,
             :run,
             :aliases

  def self.parse(input)
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

    matches.first.execute(input)
  end

  def execute(input)
    not_implemented if run.nil?

    matches = match.match(resolve_alias input)
    arguments = [matches.names, matches.captures].transpose.to_h.with_indifferent_access

    run.call(arguments)
  end

  def chain(command, args=nil)
    command.run.call(args)
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
end
