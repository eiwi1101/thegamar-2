require 'spec_helper'

describe Room do
  subject { Room }

  its(:count) { is_expected.to_not eq 0 }

  describe 'scary room' do
    subject { SCARY_ROOM }

    its(:name) { is_expected.to eq "A Scary Room" }
  end
end
