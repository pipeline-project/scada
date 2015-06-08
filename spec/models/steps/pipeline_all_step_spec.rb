require 'rails_helper'

describe Steps::PipelineAllStep do
  let(:pipeline) do
    Pipeline.create! name: 'Sub Pipeline' do |p|
      p.steps << Steps::IdentityStep.new
    end
  end

  subject { described_class.new pipeline_a_id: pipeline.id, pipeline_b_id: pipeline.id }

  describe '#perform' do
    it 'processes the message through the sub-pipeline' do
      expect(subject.perform_one('a').map(&:payload)).to match_array ['a', 'a']
    end
  end
end
