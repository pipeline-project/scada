require 'csv'

module Steps
  class ParseCsvStep < Step
    store_accessor :options, :col_sep, :row_sep, :quote_char, :headers

    def perform_one(record, _params = {})
      return to_enum(:perform_one, record, _params) unless block_given?

      CSV.parse(record, parse_options) do |row|
        yield row.to_h
      end
    end

    def parse_options
      @parse_options ||= {
        headers: headers_option,
        col_sep: col_sep,
        row_sep: row_sep,
        quote_char: quote_char
      }.reject { |_k, v| v.blank? }
    end

    def headers_option
      case headers
      when "false"
        false
      when /,/
        headers.split(",").map(&:strip)
      else
        true
      end
    end
  end
end
