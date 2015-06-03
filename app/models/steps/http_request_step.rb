module Steps
  class HttpRequestStep < Step
    store_accessor :options, :url

    def perform_one(record, params = {})
      return to_enum(:perform_one, record, params) unless block_given?

      uris = [render(record, url) || record.payload]
      loop do
        uri = uris.pop

        response = http_client.get uri

        if response.success?
          yield record.new_child(response)
          uris += link_rels(response)
        end

        break if uris.empty?
      end
    end

    private

    def link_rels(response)
      Array.wrap(response.header[:link]).
        flat_map { |x| LinkHeader.parse(x).links }.
        select { |x| x.attr_pairs.include? ['rel', 'next'] }.
        map(&:href)
    end

    def http_client
      @http_client ||= begin
        c = Hurley::Client.new
        c.request_options.redirection_limit = 10
        c
      end
    end
  end
end
