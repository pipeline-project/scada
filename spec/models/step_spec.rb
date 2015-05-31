require 'rails_helper'

RSpec.describe Step, type: :model do
  describe '#perform' do
    it 'gracefully handles errors' do
      expect(subject.send(:logger)).to receive(:warn)
      allow(subject).to receive(:perform_one).and_raise StandardError
      expect { subject.perform([Message.new]).to_a }.not_to raise_exception
    end
  end
end
