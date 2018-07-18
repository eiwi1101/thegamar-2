class Command
  include DslBase

  attributes :name,
             :match,
             :description,
             :run

  def self.parse(input)
    input.downcase!

    matches = defined.select do |command|
      command.match =~ input
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

    matches = match.match(input)
    arguments = [matches.names, matches.captures].transpose.to_h.with_indifferent_access

    run.call(arguments)
  end

  def chain(command, args=nil)
    command.run.call(args)
  end
end
