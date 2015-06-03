module Steps
  class GsubStep < EnrichStep
    store_accessor :options, :pattern, :replacement

    def enrich_value(record, _field, value)
      value.gsub(Regexp.new(render(record, pattern)), render(record, replacement))
    end
  end
end
