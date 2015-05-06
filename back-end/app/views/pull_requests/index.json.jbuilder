json.array!(@pull_requests) do |pull_request|
  json.extract! pull_request, :id, :id, :url, :number, :state, :user_id, :created_at, :updated_at, :closed_at, :merged_at
  json.url pull_request_url(pull_request, format: :json)
end
