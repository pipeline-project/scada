module Steps
  class RemoveEmptyValuesStep < EnrichStep
    def enrich_value(_record, _field, value)
      if value.nil? || value.empty? || (value.is_a?(String) && value.strip.empty?)
        nil
      else
        value
      end
    end
  end
end
