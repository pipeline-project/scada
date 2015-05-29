# A single pipeline
class Pipeline < ActiveRecord::Base
  has_many :steps
  accepts_nested_attributes_for :steps

  def ordered_steps
    @ordered_steps ||= []
  end

  def perform(seed)
    return to_enum(:perform, seed) unless block_given?

    ordered_steps.inject(seed) do |memo, step|
      step.perform(memo)
    end.each do |r|
      yield r
    end
  end
end
