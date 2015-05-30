require 'rails_helper'

describe Steps::ExtractValueStep do
  describe "#perform" do
    subject { described_class.new fields: :a, pattern: /([0-9]+)/ }
    let(:record) { { a: 'a, 123, fds1' } }
    it "extracts the value of a field by a pattern" do
      subject.perform_one(record)
      expect(record[:a]).to match_array ['123', '1']
    end
  end
end
