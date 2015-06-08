module Steps
  class PipelineAllStep < Step
    store_accessor :options, :condition, :pipeline_a_id, :pipeline_b_id

    def perform_one(record, params = {}, &block)
      return to_enum(:perform_one, record, params) unless block_given?

      pipeline_a.perform(record, &block)
      pipeline_b.perform(record, &block)
    end

    private

    def pipeline_a
      @pipeline ||= Pipeline.find(pipeline_a_id)
    end

    def pipeline_b
      @pipeline ||= Pipeline.find(pipeline_b_id)
    end
  end
end
