class Prompt
  def self.command_prefix
    objects = {
        room: (PlayerState.instance.current_room&.name || '<no room>').colorize(:light_green),
        prompt: '>'.colorize(:light_blue)
    }

    "[%{room}]\n%{prompt} " % objects
  end

  def initialize(narrate, metadata = nil)
    @narrate = narrate
    @metadata = metadata
  end

  def print
    puts @narrate.colorize(:white)

    _print_table @metadata[:table] if @metadata&[:table]
  end

  private

  def _print_table(table)
    col_sep = '|'.colorize(:light_black)
    row_sep = '-'.colorize(:light_black)
    row_pad = ' '

    col_lengths = table.transpose.collect do |col|
      col.collect(&:length).max
    end

    format = col_sep + row_pad + col_lengths.collect { |l| "%-#{l}s" }.join(row_pad + col_sep + row_pad) + row_pad + col_sep
    row_string = (format % col_lengths.collect { |l| row_sep * l }).tr('|', '+')

    puts row_string

    table.each do |row|
      puts format % row
      puts row_string
    end
  end
end
