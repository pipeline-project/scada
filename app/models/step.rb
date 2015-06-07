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
  def perform(messages = nil, params = {}, &block)
    logger.debug "#{self}(#{params.inspect}) <- #{messages}"
    return to_enum(:perform, messages, params) unless block_given?

    wrap_input(messages).each do |m|
      run_callbacks :perform do
        logger.debug "#{object_id} -> #{m}"
        result = perform_one(m, params)
        handle_result(m, result, &block)
      end
    end
  end

  def perform_one(message, _params = {})
    message
  end

  def >>(other)
    other
  end

  private

  def wrap_input(messages)
    if messages.respond_to? :each
      messages
    else
      Array.wrap(messages)
    end
  end

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

  def handle_result(message, result)
    return unless result
    return to_enum(:handle_result, message, result) unless block_given?

    if result.is_a?(Enumerable) && !result.is_a?(Hash)
      result.each { |r| yield wrap(message, r) }
    else
      yield wrap(message, result)
    end
  end

  def handle_exception(e)
    logger.warn e
  end

  def wrap(message, result)
    if field?
      if message.payload.is_a? Hash
        message.payload[field] = result
      else
        message.payload = { field => result }
      end

      message
    else
      result
    end.tap { |r| logger.debug "#{self} #{message} => #{r.inspect}" }
  end

  def field?
    field.present?
  end

  def logger
    @logger ||= Logger.new(STDERR).tap { |l| l.level = Logger::INFO }
  end

  def render(record, value)
    if value.present? && value.is_a?(String)
      Mustache.render(value, record.payload)
    else
      value
    end
  end
end
