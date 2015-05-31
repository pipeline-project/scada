module Steps
  class ListDirectoryPatternStep < Step
    store_accessor :options, :glob

    def perform(record_or_enumerable = nil, params = {}, &block)
      super input_glob, params, &block
    end

    def input_glob
      if glob.present?
        [Message.new(payload: glob)]
      else
        record_or_enumerable
      end
    end

    def perform_one(record, params = {})
      return to_enum(:perform_one, record, params) unless block_given?

      Dir.glob(record.payload) do |d|
        yield record.new_child(d)
      end
    end
  end
end
