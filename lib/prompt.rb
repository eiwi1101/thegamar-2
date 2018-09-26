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

  def initialize(message_or_metadata, metadata = {})
    if message_or_metadata.is_a? Hash
      metadata = message_or_metadata.merge(metadata)
      message = metadata[:message]
    else
      message = message_or_metadata
    end

    @message = message
    @metadata = metadata
  end

  def print
    if (title = @metadata[:title])
      puts title.colorize(:black)
    end

    if @message =~ /\x1b/
      puts @message
    else
      puts @message.colorize(:white)
    end

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

    if ENV['DEBUG']
      puts
      puts @metadata[:metadata].to_json.colorize(:light_black)
    end
  end

  def as_json(options={})
    data = {
        message: @message
    }.merge(@metadata)
  end

  private

  def _print_table(table)
    return _print_hash(table) if table.is_a? Hash
    col_sep = ' - '.colorize(:light_black)
    row_pad = ''

    col_lengths = table.transpose.collect do |col|
      col.collect(&:length).max
    end

    format = row_pad + col_lengths.collect { |l| "%-#{l}s" }.join(row_pad + col_sep + row_pad) + row_pad

    puts

    table.each do |row|
      puts format % row
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
