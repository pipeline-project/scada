module Steps
  class ItemLevelStep < Step
    store_accessor :options, :level

    def perform_one(record, params = {})
      l = params.fetch(:level, level)

      if record.respond_to? l
        record.public_send(l)
      elsif record.respond_to? :[]
        record[l]
      end
    end
  end
end
