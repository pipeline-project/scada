module Steps
  class ReadFileStep < Step
    def perform_one(record, _params = {})
      record.payload = File.read(record.payload)
      record
    end
  end
end
