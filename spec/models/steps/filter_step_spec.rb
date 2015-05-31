require 'rails_helper'

describe Steps::FilterStep do
  describe '#perform' do
    subject { described_class.new fields: :a }
    let(:matching_record) { { a: 'a' } }
    let(:nonmatching_record) { {} }

    it 'passes through the record if a field is present' do
      expect(subject.perform_one(matching_record)).to eq matching_record
    end

    it 'filters out records that do not have the field' do
      expect(subject.perform_one(nonmatching_record)).to be_blank
    end
  end
end
