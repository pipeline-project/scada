module Steps
  class ListDirectoryPatternStep < Step
    store_accessor :options, :glob

    def perform_one(record, params, &block)
      return to_enum(:perform_one, record, params) unless block_given?
      Dir.glob(glob || record, &block)
    end
  end
end
