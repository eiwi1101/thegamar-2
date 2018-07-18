class CommandError < GameError
  def initialize(message, input, metadata={})
    @input = input
    @metadata = metadata
    super(message)
  end
end
