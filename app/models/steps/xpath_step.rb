module Steps
  class XpathStep < Step
    store_accessor :options, :xpath

    def perform_one(record, params)
      xpaths = params.fetch(:xpath, xpath)
      doc = Nokogiri::XML(record)

      xpaths.each_with_object({}) do |(key, xpath), h|
        h[key.to_s] ||= []
        h[key.to_s] += doc.xpath(xpath).map(&:to_s)
      end
    end
  end
end
