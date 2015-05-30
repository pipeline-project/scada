require 'rails_helper'

describe Steps::SplitValueStep do
  describe "#enrich_field" do
    subject { described_class.new pattern: ',' }
    let(:record) { { a: 'a,b,c' } }
    it "splits the value of a field by a delimiter" do
      subject.enrich_field(record, :a)
      expect(record[:a]).to match_array ['a', 'b', 'c']
    end
  end
end
