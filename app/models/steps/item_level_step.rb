module Steps
  class ItemLevelStep < Step
    def perform_one(record, params)
      record[level(params[:level])]
    end

    private

    def level(level)
      level || options[:level]
    end
  end
end
