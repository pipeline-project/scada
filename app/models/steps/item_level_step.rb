module Steps
  class ItemLevelStep < Step
    store_accessor :options, :level

    def perform_one(record, params = {})
      return to_enum(:perform_one, record, params) unless block_given?

      result = traverse(record.payload, render(record, params.fetch(:level, level)))

      if result.respond_to? :each
        result.each do |r|
          yield record.new_child(r)
        end
      else
        yield record.new_child(result)
      end
    end

    def traverse(record, level)
      if record.respond_to? level
        record.public_send(level)
      elsif record.respond_to? :[]
        record[level]
      else
        raise "Can't traverse object"
      end
    end
  end
end
