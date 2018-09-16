module CommandHelper
  def expect_args(input, args={})
    expect(described_class).to receive(:perform).with(hash_including args)
    described_class.execute(input)
  end

  def run(input_or_args)
    if input_or_args.is_a? Array
      input_or_args.collect { |ia| run(ia) }
    elsif input_or_args.is_a? Hash
      described_class.send(:perform, input_or_args)
    else
      described_class.execute(input)
    end
  end
end
