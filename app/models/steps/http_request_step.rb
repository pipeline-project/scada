module Steps
  class HttpRequestStep < Step
    def perform_one(record, params)
      return to_enum(:perform_one, record, params) unless block_given?

      uris = [record]
      loop do
        uri = uris.pop

        response = http_client(record).get uri

        if response.success?
          yield response
          uris += link_rels(response)
        end

        break if uris.empty?
      end
    end

    private

    def link_rels(response)
      Array.wrap(response.header[:link]).flat_map { |x| LinkHeader.parse(x).links }.select { |x| x.attr_pairs.include? ["rel", "next"] }.map { |x| x.href }
    end

    def http_client(record)
      @http_client ||= begin
        c = Hurley::Client.new record
        c.request_options.redirection_limit = 10
        c
      end
    end
  end
end