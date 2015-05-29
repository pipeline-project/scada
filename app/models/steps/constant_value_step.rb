module Steps
  class ConstantValueStep < EnrichStep
    def enrich_field(record, field)
      record[field] = value
    end

    def enrich_value(_record, _field, _value)
      value
    end

    private

    def value
      options[:value]
    end
  end
end
