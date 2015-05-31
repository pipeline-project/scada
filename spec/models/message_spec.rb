require 'rails_helper'

describe Message do
  describe '.wrap' do
    it 'sets the payload to the wrapped element' do
      m = Message.wrap('a')
      expect(m).to be_a_kind_of Message
      expect(m.payload).to eq 'a'
    end

    it 'does not re-wrap messages' do
      m = Message.new
      expect(Message.wrap(m)).to eq m
    end
  end
end