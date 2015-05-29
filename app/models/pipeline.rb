# A single pipeline
class Pipeline
  def steps
    @steps ||= []
  end

  def perform(seed)
    return to_enum(:perform, seed) unless block_given?

    steps.inject(seed) do |memo, step|
      step.perform(memo)
    end.each do |r|
      yield r
    end
  end
end
