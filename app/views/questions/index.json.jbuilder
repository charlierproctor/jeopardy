json.array!(@questions) do |question|
  json.extract! question, :id, :number, :points, :prompt, :tests
  json.url question_url(question, format: :json)
end
