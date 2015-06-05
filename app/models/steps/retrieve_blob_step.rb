module Steps
  class RetrieveBlobStep < Step
    store_accessor :options, :tag

    def perform_one(record, params = {})
      return to_enum(:perform_one, record, params) unless block_given?

      Blob.where(tag: render(record, tag)).find_each do |b|
        yield record.new_child(b.data)
      end
    end
  end
end
