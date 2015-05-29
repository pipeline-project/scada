module Steps
  class ListDirectoryPatternStep < Step
    def perform_one(record, params, &block)
      return to_enum(:perform_one, record, params) unless block_given?
      Dir.glob(record, &block)
    end
  end
end
