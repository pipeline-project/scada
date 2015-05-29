module Steps
  class ExtractValueStep < EnrichStep
    store_accessor :options, :pattern

    def enrich_value(_record, _field, value)
      value.scan(pattern).flatten
    end
  end
end
