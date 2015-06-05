module Steps
  class PipelineStep < Step
    store_accessor :options, :pipeline_id

    def perform_one(record, params = {}, &block)
      return to_enum(:perform_one, record, params) unless block_given?

      pipeline.perform(record, &block)
    end

    private

    def pipeline
      @pipeline ||= Pipeline.find(pipeline_id)
    end
  end
end
