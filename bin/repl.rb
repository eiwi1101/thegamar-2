#!ruby

require_relative '../thegamar'

unless ENV['DEBUG']
  unless system('clear')
    system('cls')
    puts "WARNING: Does your terminal support ANSI?"
  end
end

command_history = []
puts "Welcome to Thegamar!".colorize(:light_yellow)

player = Player.new name: "Repl"

player.on_prompt do |prompt|
  prompt.print
end

loop do
  puts
  print Prompt.command_prefix(player)

  if $*.any?
    command = $*&.join(' ')
    puts command
  end

  begin
    command ||= gets
    command_history.push command
  rescue Interrupt => _e
    break
  end

  break if command =~ /^exit|quit$/i
  String.color_samples if command == 'strcol'

  begin
    Command.parse(player, command)
  rescue GameError => e
    e.print
  rescue => e
    if ENV['DEBUG']
      print "Uncaught #{e.class.name}: ".colorize(:light_red)
      puts e.message.colorize(:red)
      puts e.backtrace.join("\n").colorize(:light_black)
    else
      puts "Something went wrong :(".colorize(:red)
    end
  end

  break if $*.any?
end

puts
puts "Good bye!".colorize(:light_yellow)
