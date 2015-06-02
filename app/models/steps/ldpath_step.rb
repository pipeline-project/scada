module Steps
  class LdpathStep < Step
    store_accessor :options, :program

    def perform_one(record, _params = {})
      Addressable::URI.parse(record.payload)

      ldpath_program.evaluate(record.payload)
    rescue Addressable::InvalidURIError => e
      { error: { input: record.payload, exception: e } }
    end

    private

    def ldpath_program
      @ldpath_program ||= Ldpath::Program.parse program
    end
  end
end
