module Steps
  class ConstantValueStep < EnrichStep
    def enrich_field(record, field)
      record[field] = value
    end

    private

    def value
      options[:value]
    end
  end
end
