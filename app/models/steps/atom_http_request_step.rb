require 'rss'

module Steps
  class AtomHttpRequestStep < HttpRequestStep
    def next_documents(response)
      (super + atom_links(response)).uniq
    end

    def atom_links(response)
      feed = RSS::Parser.parse(response.body)
      if feed
        feed.links.select { |l| l.rel == 'next' }.map(&:href)
      else
        []
      end
    end
  end
end
