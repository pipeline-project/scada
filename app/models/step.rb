# One step in a pipeline
class Step
  attr_reader :pipeline, :options

  ##
  # Initialize a new step for a pipeline
  # @param [Pipeline] pipeline
  # @options [Hash] options
  def initialize(pipeline, options = {})
    @pipeline = pipeline
    @options = options
  end

  ##
  # Execute the step on a given set of records
  def perform(record_or_enumerable, params = {}, &block)
    return to_enum(:perform, record_or_enumerable, params) unless block_given?

    case record_or_enumerable
    when Enumerable
      record_or_enumerable.each do |record|
        result = perform_one(record, params)
        handle_result(record, result, &block)
      end
    else
      record = record_or_enumerable
      result = perform_one(record, params)
      handle_result(record, result, &block)
    end
  end

  def handle_result(record, result)
    return to_enum(:handle_result, record, result) unless block_given?

    if result.is_a? Enumerable
      result.each { |r| yield wrap(record, r) }
    else
      yield wrap(record, result)
    end
  end

  def wrap(record, result)
    if options[:field]
      if record.is_a? Hash
        record[options[:field]] = result
      else
        { options[:field] => result }
      end
    else
      result
    end
  end
end
