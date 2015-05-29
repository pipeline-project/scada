module Steps
  class ConstantValueStep < EnrichStep
    store_accessor :options, :value

    def enrich_field(record, field)
      record[field] = value
    end

    def enrich_value(_record, _field, _value)
      value
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
