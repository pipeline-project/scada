module Steps
  class SplitValueStep < EnrichStep
    store_accessor :options, :pattern

    def enrich_value(_record, _field, value)
      value.split(pattern).flatten
    end
  end
end
