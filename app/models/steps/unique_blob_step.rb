module Steps
  class UniqueBlobStep < StoreBlobStep
    store_accessor :options, :tag

    def perform_one(record, params = {})
      return to_enum(:perform_one, record, params) unless block_given?

      b = Blob.find_or_initialize_by(step: self, unique_id: unique_id(record))
      b.data = record.payload
      b.tag = render(record, tag)

      if b.new_record?
        b.save!
        yield record
      else
        b.save!
      end
    end
  end
end
