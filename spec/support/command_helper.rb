module CommandHelper
  def expect_args(input, args={})
    player ||= Player.new

    expect(described_class).to receive(:perform).with(player, hash_including(args))
    described_class.execute(player, input)
  end

  def run(input_or_args)
    player ||= Player.new

    if input_or_args.is_a? Array
      input_or_args.collect { |ia| run(ia) }
    elsif input_or_args.is_a? Hash
      described_class.send(:perform, player, input_or_args)
    else
      described_class.execute(player, input)
    end
  end
end
