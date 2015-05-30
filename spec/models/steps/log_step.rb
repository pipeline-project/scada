require 'rails_helper'

describe Steps::LogStep do
  subject { described_class.new }

  describe "#perform" do
    it "should log the arguments to the logger" do
      expect(Rails.logger).to receive(:info).with('a')
      expect(subject.perform_one('a')).to eq 'a'
    end
  end
end