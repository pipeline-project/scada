module Steps
  class GsubStep < EnrichStep
    def enrich_value(_record, _field, value)
      value.gsub(pattern, replacement)
    end

    private

    def pattern
      Regexp.new(options[:pattern])
    end

    def replacement
      options[:replacement]
    end
  end
end