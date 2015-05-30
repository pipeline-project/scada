require 'rails_helper'

describe Steps::RemoveEmptyValuesStep do
  describe "#enrich_field" do
    let(:record) { { a: ["", "a"], b: "", c: "c", d: [] } }
    it "removes empty elements from an array" do
      subject.enrich_field(record, :a)
      expect(record[:a]).to match_array ["a"]
    end

    it "removes empty arrays" do
      subject.enrich_field(record, :d)
      expect(record).not_to have_key :d
    end

    it "removes empty strings" do
      subject.enrich_field(record, :b)
      expect(record).not_to have_key :b
    end

    it "passes through other values unchanged" do
      subject.enrich_field(record, :c)
      expect(record[:c]).to eq "c"
    end
  end

  describe "#enrich_value" do
    it "converts nil to nil" do
      expect(subject.enrich_value(nil, nil, nil)).to eq nil
    end

    it "converts an empty string to nil" do
      expect(subject.enrich_value(nil, nil, "")).to eq nil
    end

    it "converts a string with only whitespace to nil" do
      expect(subject.enrich_value(nil, nil, "  \n \t \r ")).to eq nil
    end

    it "passes other values through unchanged" do
      expect(subject.enrich_value(nil, nil, "abc")).to eq "abc"
    end
  end
end
