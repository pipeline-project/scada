module Steps
  class ExtractValueStep < EnrichStep
    store_accessor :options, :pattern

    def enrich_value(record, _field, value)
      value.scan(render(record, pattern)).flatten
    end
  end
end
