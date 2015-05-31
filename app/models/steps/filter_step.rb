module Steps
  class FilterStep < Step
    store_accessor :options, :fields

    def perform_one(record, params = {})
      target_fields = params.fetch(:fields, fields)

      res = if target_fields
              Array.wrap(target_fields).any? do |field|
                filter_field record, field
              end
            else
              filter_value(record, nil, record.payload)
            end

      record if res
    end

    def filter_field(record, field)
      Array.wrap(record.payload[field]).any? { |v| filter_value(record, field, v) }
    end

    def filter_value(_record, _field, value)
      value.present?
    end
  end
end
