class Prompt
  def self.command_prefix(player)
    hp = player.health.percent_display
    thp = player.current_target&.health&.percent_display

    objects = {
        hp: hp.colorize(:green),
        thp: thp&.colorize(:yellow),
        room: (player.current_room&.name || '<no room>').colorize(:light_green),
        prompt: '>'.colorize(:light_blue)
    }

    data = [
       "%{room}",
       "%{hp}"
    ]

    data.push "T:%{thp}" if thp.present?

    "[#{data.join(" - ")}]\n%{prompt} " % objects
  end

  def initialize(narrate, metadata = {})
    @narrate = narrate
    @metadata = metadata
  end

  def print
    puts @narrate.colorize(:white)

    if (subtle = @metadata[:subtle])
      @metadata[:additional] ||= []
      @metadata[:additional].unshift subtle.colorize(:light_black)
    end

    if (additional = @metadata[:additional])
      additional = [additional] unless additional.is_a? Array
      additional.each do |line|
        puts line.to_s
      end
    end

    _print_table @metadata[:table] if @metadata[:table]
    _print_hash @metadata[:hash] if @metadata[:hash]
  end

  private

  def _print_table(table)
    return _print_hash(table) if table.is_a? Hash
    col_sep = ''.colorize(:light_black)
    row_sep = ''.colorize(:light_black)
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

  def _print_hash(hash)
    puts
    hash.each do |k, v|
      puts "%s#{':'.colorize(:white)} %s" % [
          k.to_s.humanize.colorize(:white),
          v.to_s
      ]
    end
  end
end
