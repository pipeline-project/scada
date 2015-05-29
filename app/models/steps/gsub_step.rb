module Steps
  class GsubStep < EnrichStep
    store_accessor :options, :pattern, :replacement

    def enrich_value(_record, _field, value)
      value.gsub(Regexp.new(pattern), replacement)
    end
  end
end