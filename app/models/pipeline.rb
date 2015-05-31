# A single pipeline
class Pipeline < ActiveRecord::Base
  validates :name, presence: true

  has_many :steps
  accepts_nested_attributes_for :steps

  def perform(seed = nil)
    return to_enum(:perform, seed) unless block_given?

    results = steps.inject(seed) do |memo, step|
      step.perform(memo)
    end

    results.each do |r|
      yield r
    end
  end
end
