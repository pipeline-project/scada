module Steps
  class EnrichStep < Step
    def perform_one(record, params)
      fields = fields(params[:fields])
      if fields
        fields.each do |field|
          enrich_field record, field
        end

        record
      else
        enrich_value(record, nil, record)
      end
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
      v = fields || options[:fields]
      Array.wrap(v) if v
    end
  end
end
