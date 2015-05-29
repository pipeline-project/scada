module Steps
  class ItemLevelXpathStep < Step
    def perform_one(record, params)
      Nokogiri::XML(record).xpath(xpath(params[:xpath])).map(&:to_s)
    end

    private

    def xpath(xpath)
      xpath || options[:xpath]
    end
  end
end
