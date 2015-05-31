module Steps
  class HttpPostRequestStep < Step
    store_accessor :options, :url

    def perform_one(record, _params = {})
      http_client.post(url) do |req|
        req.body = record
      end
    end

    private

    def http_client
      @http_client ||= Hurley::Client.new
    end
  end
end
