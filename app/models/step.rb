# One step in a pipeline
class Step < ActiveRecord::Base
  belongs_to :pipeline
  default_scope { order(order: :asc) }

  store :options, accessors: [:field], coder: JSON

  define_callbacks :perform

  set_callback :perform, :around, ->(_, block) { perform_with_instrumentation(block) }
  set_callback :perform, :around, ->(_, block) { perform_with_error_handling(block) }

  def self.all_stored_options
    Step.subclasses.map { |x| x.stored_attributes[:options] }.flatten.uniq
  end

  ##
  # Execute the step on a given set of records
  def perform(record_or_enumerable = nil, params = {}, &block)
    logger.debug "#{self}(#{params.inspect}) <- #{record_or_enumerable}"
    return to_enum(:perform, record_or_enumerable, params) unless block_given?

    case record_or_enumerable
    when Enumerable
      record_or_enumerable.each do |record|
        result = run_callbacks :perform do
          perform_one(record, params)
        end
        handle_result(record, result, &block)
      end
    else
      record = record_or_enumerable
      result = run_callbacks :perform do
        perform_one(record, params)
      end
      handle_result(record, result, &block)
    end
  end

  def perform_one(record, _params = {})
    record
  end

  private

  def perform_with_instrumentation(block)
    ActiveSupport::Notifications.instrument('step.perform_one', notification_payload) do
      block.call
    end
  end

  def notification_payload
    @notification_payload ||= { class: self.class, global_id: (to_global_id if persisted?) }
  end

  def perform_with_error_handling(block)
    block.call
  rescue => e
    handle_exception(e)
  end

  def handle_result(record, result)
    return unless result
    return to_enum(:handle_result, record, result) unless block_given?

    if result.is_a?(Enumerable) && !result.is_a?(Hash)
      result.each { |r| yield wrap(record, r) }
    else
      yield wrap(record, result)
    end
  end

  def handle_exception(e)
    logger.warn e
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
    @logger ||= Logger.new(STDERR).tap { |l| l.level = Logger::WARN }
  end
end
