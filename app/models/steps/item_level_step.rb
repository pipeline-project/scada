module Steps
  class ItemLevelStep < Step
    def perform_one(record, params)
      l = level(params[:level])
      if record.respond_to? l
        record.public_send(l)
      elsif record.respond_to? :[]
        record[l]
      end
    end

    private

    def level(level)
      level || options[:level]
    end
  end
end
