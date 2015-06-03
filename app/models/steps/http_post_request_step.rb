module Steps
  class HttpPostRequestStep < Step
    store_accessor :options, :url

    def perform_one(record, _params = {})
      record.payload = http_client.post(render(record, url)) do |req|
        req.body = record.payload
      end

      record
    end

    private

    def http_client
      @http_client ||= Hurley::Client.new
    end
  end
end
