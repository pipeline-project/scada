module Steps
  class IdentityStep < Step
    def perform_one(record, _params)
      record
    end
  end
end
