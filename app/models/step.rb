# One step in a pipeline
class Step < ActiveRecord::Base
  belongs_to :pipeline
  default_scope { order(order: :asc) }

  store :options, accessors: [:field], coder: JSON

  def self.all_stored_options
    Step.subclasses.map { |x| x.stored_attributes[:options] }.flatten.uniq
  end

  ##
  # Execute the step on a given set of records
  def perform(record_or_enumerable, params = {}, &block)
    logger.debug "#{self}(#{params.inspect}) <- #{record_or_enumerable}"
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

  def perform_one(record, params = {})
    record
  end

  private

  def handle_result(record, result)
    return to_enum(:handle_result, record, result) unless block_given?

    if result.is_a?(Enumerable) && !result.is_a?(Hash)
      result.each { |r| yield wrap(record, r) }
    else
      yield wrap(record, result)
    end
  end

  def wrap(record, result)
    if field?
      if record.is_a? Hash
        record[field] = result
      else
        { field => result }
      end
    else
      result
    end.tap { |r| logger.debug "#{self} #{record} => #{r.inspect}" }
  end

  def field?
    field.present?
  end

  def logger
    @logger ||= Logger.new('/dev/null')
  end
end
