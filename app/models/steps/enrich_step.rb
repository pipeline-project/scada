module Steps
  class EnrichStep < Step
    store_accessor :options, :fields

    def perform_one(record, params = {})
      target_fields = params.fetch(:fields, fields)

      if target_fields
        Array.wrap(target_fields).each do |field|
          enrich_field record, field
        end
      else
        record.payload = enrich_value(record, nil, record.payload)
      end

      record
    end

    def enrich_field(record, field)
      if record.payload[field].is_a? Array
        record.payload[field] = record.payload[field].map { |v| enrich_value(record, field, v) }.compact
      else
        record.payload[field] = enrich_value(record, field, record.payload[field])
      end

      record.payload.delete(field) if record.payload[field].blank?

      record.payload[field]
    end

    def enrich_value(_record, _field, value)
      value
    end
  end
end
