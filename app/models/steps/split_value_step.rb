module Steps
  class SplitValueStep < EnrichStep
    store_accessor :options, :pattern

    def enrich_value(record, _field, value)
      value.split(render(record, pattern)).flatten
    end
  end
end
