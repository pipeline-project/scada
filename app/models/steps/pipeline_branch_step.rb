module Steps
  class PipelineBranchStep < Step
    store_accessor :options, :condition, :pipeline_true_id, :pipeline_false_id

    def perform_one(record, params = {}, &block)
      return to_enum(:perform_one, record, params) unless block_given?

      if condition?(record)
        pipeline_true.perform(record, &block)
      else
        pipeline_false.perform(record, &block)
      end

      render(record, condition)

    end

    private

    def condition?(record)
      true
    end

    def pipeline_true
      @pipeline ||= Pipeline.find(pipeline_true_id)
    end

    def pipeline_false
      @pipeline ||= Pipeline.find(pipeline_false_id)
    end
  end
end
