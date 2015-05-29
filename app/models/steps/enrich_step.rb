module Steps
  class EnrichStep < Step
    store_accessor :options, :fields

    def perform_one(record, params)
      target_fields = params.fetch(:fields, fields)

      if target_fields
        Array.wrap(target_fields).each do |field|
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
  end
end
