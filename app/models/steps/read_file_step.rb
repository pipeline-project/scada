module Steps
  class ReadFileStep < Step
    def perform_one(record, _params)
      File.read(record)
    end
  end
end
