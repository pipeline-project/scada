require 'securerandom'

module Steps
  class StoreBlobStep < Step
    store_accessor :options, :tag, :unique_id_field

    def perform_one(record, _params = {})
      b = Blob.find_or_initialize_by(unique_id: unique_id(record))
      b.data = record.payload
      b.tag = render(record, tag)
      b.step = self
      b.save!

      record
    end

    private

    def unique_id(record)
      field = render(record, unique_id_field)

      if field.blank?
        SecureRandom.uuid
      elsif record.payload.respond_to? field
        record.payload.send(field)
      elsif record.payload.respond_to? :[]
        record.payload[field]
      end
    end
  end
end
