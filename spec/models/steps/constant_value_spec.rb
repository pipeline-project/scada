require 'rails_helper'

describe Steps::ConstantValueStep do
  describe "#enrich_field" do
    subject { described_class.new value: "a" }
    let(:record) { {} }
    it "sets a field to a constant value" do
      subject.enrich_field(Message.wrap(record), :a)
      expect(record[:a]).to eq "a"
    end

    it 'evaluates a mustache template' do
      record[:a] = 1
      subject.value = "!{{a}}"
      subject.enrich_field(Message.wrap(record), :b)
      expect(record[:b]).to eq "!1"
    end
  end
end
