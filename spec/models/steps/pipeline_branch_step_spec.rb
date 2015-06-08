require 'rails_helper'

describe Steps::PipelineBranchStep do
  let(:pipeline_true) do
    Pipeline.create! name: 'Sub Pipeline (true)' do |p|
      p.steps << Steps::IdentityStep.new
    end
  end

  let(:pipeline_false) do
    Pipeline.create! name: 'Sub Pipeline (false)' do |p|
      p.steps << Steps::ConstantValueStep.new(value: 'b')
    end
  end

  subject { described_class.new pipeline_true_id: pipeline_true.id, pipeline_false_id: pipeline_false.id }

  describe '#perform' do
    it 'processes the message through the "true" sub-pipeline' do
      expect(subject.perform_one('a').map(&:payload)).to match_array ['a']
    end

    it 'processes the message through the "false" sub-pipeline' do
      allow(subject).to receive(:condition?).and_return(false)
      expect(subject.perform_one('a').map(&:payload)).to match_array ['b']
    end
  end
end
