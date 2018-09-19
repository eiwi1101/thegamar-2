require 'spec_helper'

describe Command do
  subject { Command }

  before(:each) { PlayerState.init }

  its(:count) { is_expected.to_not eq 0 }

  context 'expecting room description' do
    let(:expected) { "You see before you a small, concrete chamber. Dried brown bloodstains " +
                     "cover the cracked, concrete floor. It reeks of death." }

    it 'parses look' do
      expect(Prompt).to receive(:new).with(expected).and_call_original
      Command.parse 'LOOK'
    end

    describe 'look' do
      subject { C_LOOK }

      its(:name) { is_expected.to eq "Look" }

      it 'runs' do
        input = "look"

        expect(Prompt).to receive(:new).with(expected).and_call_original
        subject.execute(input)
      end
    end
  end
end
