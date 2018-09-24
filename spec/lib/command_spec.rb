require 'spec_helper'

describe Command do
  let(:player) { Player.new }

  subject { Command }

  its(:count) { is_expected.to_not eq 0 }

  context 'expecting room description' do
    let(:expected) { "A Scary Room".colorize(:black) }

    it 'parses look' do
      expect(Prompt).to receive(:new).with(expected, any_args).and_call_original
      Command.parse player, 'LOOK'
    end

    describe 'look' do
      subject { C_LOOK }

      its(:name) { is_expected.to eq "Look" }

      it 'runs' do
        input = "look"

        expect(Prompt).to receive(:new).with(expected, any_args).and_call_original
        subject.execute(player, input)
      end
    end
  end
end
