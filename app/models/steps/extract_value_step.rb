module Steps
  class ExtractValueStep < EnrichStep
    def enrich_value(_record, _field, value)
      value.scan(pattern).flatten
    end

    private

    def pattern
      options[:pattern]
    end
  end
end
