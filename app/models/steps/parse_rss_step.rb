require 'rss'

module Steps
  class ParseRssStep < Step
    def perform_one(record, _params = {})
      return to_enum(:perform_one, record, _params) unless block_given?

      feed = RSS::Parser.parse(record.payload)

      feed.items.each do |item|
        yield record.new_child(item)
      end
    end
  end
end
