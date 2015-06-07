# A single pipeline
class Pipeline < ActiveRecord::Base
  validates :name, presence: true

  has_many :steps
  accepts_nested_attributes_for :steps

  def perform(seed = nil)
    return to_enum(:perform, seed) unless block_given?

    results = steps.inject(wrap_seed(seed)) do |memo, step|
      step.perform(memo)
    end

    results.each do |r|
      yield r
    end
  end

  def define(&block)
    self.steps = StepDSL.new(&block).steps
    self
  end

  class StepDSL
    attr_reader :steps
    def initialize(&block)
      @steps = []
      @aliases ||= {}

      instance_eval(&block) if block_given?
    end

    def block(short)
      @aliases[short] ||= "Steps::#{short.to_s.camelize}Step".constantize
    end

    def method_missing(m, *args)
      block(m).new(*args).tap { |b| @steps << b }
    end
  end

  private

  def wrap_seed(record_or_enumerable)
    return to_enum(:wrap_seed, record_or_enumerable) unless block_given?

    if record_or_enumerable.respond_to? :each
      record_or_enumerable.each do |x|
        yield Message.wrap(x)
      end
    else
      yield Message.wrap(record_or_enumerable)
    end
  end
end
