module Steps
  class EnrichStep < Step
    def perform_one(record, params)
      fields(params[:fields]).each do |field|
        enrich_field record, field
      end

      record
    end

    private

    def enrich_field(record, field)
      if record[field].is_a? Array
        record[field] = record[field].map { |v| enrich_value(record, field, v) }.compact
      else
        record[field] = enrich_value(record, field, record[field])
      end

      record.delete(field) if record[field].blank?

      record[field]
    end

    def enrich_value(_record, _field, value)
      value
    end

    def fields(fields)
      fields || options[:fields]
    end
  end
end
