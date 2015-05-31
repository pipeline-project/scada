module Steps
  class ParseJsonStep < Step
    def perform_one(record, _params = {})
      record.payload = JSON.parse(record.payload)
      record
    end
  end
end
