class JobsController < ApplicationController
  include ActionController::Live

  load_and_authorize_resource :pipeline, parent: false

  def stream
    response.headers['Content-Type'] = 'text/event-stream'

    sse = SSE.new(response.stream)
    begin
      @pipeline.perform(Message.wrap(params)).each do |result|
        sse.write(result.payload.to_json, event: 'message')
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end
  end
end
