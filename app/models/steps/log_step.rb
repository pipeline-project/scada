module Steps
  class LogStep < Step
    def perform_one(record, _params)
      logger.info record
      record
    end

    private

    def logger
      Rails.logger
    end
  end
end
