module Steps
  class ItemLevelXpathStep < Step
    store_accessor :options, :xpath

    def perform_one(record, params = {})
      Nokogiri::XML(record).xpath(params.fetch(:xpath, xpath)).map(&:to_s)
    end
  end
end
