class GameError < RuntimeError
  def print
    puts self.message.colorize(:red)
  end
end
