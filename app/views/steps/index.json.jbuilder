json.array!(@steps) do |step|
  json.extract! step, :id, :name, :type, :options, :pipeline_id
  json.url step_url(step, format: :json)
end
