module Steps
  class FilterPatternStep < FilterStep
    store_accessor :options, :pattern

    def filter_value(_record, _field, value)
      value =~ regexp_pattern
    end

    def regexp_pattern
      @regexp_pattern ||= Regexp.new(pattern)
    end
  end
end
