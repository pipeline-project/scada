module Steps
  class HttpRequestStep < Step
    store_accessor :options, :url

    def perform_one(record, params)
      return to_enum(:perform_one, record, params) unless block_given?

      http_client.post do |req|
        req.body = record
      end
    end

    private

    def http_client
      @http_client ||= Hurley::Client.new url
    end
  end
end
