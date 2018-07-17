#!ruby

require_relative '../thegamar'

unless ENV['DEBUG']
  unless system('clear')
    system('cls')
    puts "WARNING: Does your terminal support ANSI?"
  end
end

puts "Welcome to Thegamar!".colorize(:light_yellow)

PlayerState.init

loop do
  puts
  print Prompt.command_prefix

  if $*.any?
    command = $*&.join(' ')
    puts command
  end

  command ||= gets

  break if command =~ /^exit|quit$/i
  String.color_samples if command == 'strcol'

  begin
    result = Command.parse(command)
    result.print
  rescue => e
    puts e.message.colorize(:red)
  end

  break if $*.any?
end

puts
puts "Good bye!".colorize(:light_yellow)
