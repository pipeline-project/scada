# A single pipeline
class Pipeline < ActiveRecord::Base
  has_many :steps
  accepts_nested_attributes_for :steps

  def perform(seed)
    return to_enum(:perform, seed) unless block_given?

    steps.inject(seed) do |memo, step|
      step.perform(memo)
    end.each do |r|
      yield r
    end
  end
end
