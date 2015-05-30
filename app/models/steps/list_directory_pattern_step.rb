module Steps
  class ListDirectoryPatternStep < Step
    store_accessor :options, :glob

    def perform(record_or_enumerable = nil, params = {}, &block)
      super glob || record_or_enumerable, params, &block
    end

    def perform_one(record, params = {}, &block)
      return to_enum(:perform_one, record, params) unless block_given?
      Dir.glob(record, &block)
    end
  end
end
