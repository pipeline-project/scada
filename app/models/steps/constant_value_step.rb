module Steps
  class ConstantValueStep < EnrichStep
    store_accessor :options, :value

    def enrich_field(record, field)
      record.payload[field] = render(record, value)
    end

    def enrich_value(record, _field, _old_value)
      render(record, value)
    end

    def value
      v = super
      case v
      when Proc
        v.call
      else
        v
      end
    end
  end
end
