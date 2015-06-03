module Steps
  class FilterPatternStep < FilterStep
    store_accessor :options, :pattern

    def filter_value(record, _field, value)
      value =~ regexp_pattern(record)
    end

    def regexp_pattern(record)
      Regexp.new(render(record, pattern))
    end
  end
end
