module Steps
  class ItemLevelXpathStep < Step
    store_accessor :options, :xpath

    def perform_one(record, params = {})
      return to_enum(:perform_one, record, params) unless block_given?

      Nokogiri::XML(record.payload).xpath(render(record, params.fetch(:xpath, xpath))).each do |x|
        yield record.new_child(x.to_s)
      end
    end
  end
end
