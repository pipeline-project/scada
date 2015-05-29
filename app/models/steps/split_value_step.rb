module Steps
  class SplitValueStep < EnrichStep
    def enrich_value(_record, _field, value)
      value.split(pattern).flatten
    end

    private

    def pattern
      options[:pattern]
    end
  end
end
