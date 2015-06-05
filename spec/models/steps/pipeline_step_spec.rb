require 'rails_helper'

describe Steps::PipelineStep do
  let(:pipeline) do
    Pipeline.create! name: 'Sub Pipeline' do |p|
      p.steps << Steps::IdentityStep.new
    end
  end

  subject { described_class.new pipeline_id: pipeline.id }

  describe '#perform' do
    it 'processes the message through the sub-pipeline' do
      expect(subject.perform_one('a').map(&:payload)).to match_array ['a']
    end
  end
end
