module Steps
  class XpathStep < Step
    def perform_one(record, params)
      xpaths = xpath(params[:xpath])
      doc = Nokogiri::XML(record)

      xpaths.each_with_object({}) do |(key, xpath), h|
        h[key.to_s] ||= []
        h[key.to_s] += doc.xpath(xpath).map(&:to_s)
      end
    end

    private

    def xpath(xpath)
      xpath || options[:xpath]
    end
  end
end
