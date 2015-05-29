module Steps
  class ParseJsonStep < Step
    def perform_one(record, _params)
      JSON.parse(record)
    end
  end
end
