json.data @pull_requests do |pr|
  json.type 'pull-request'
  json.id pr.id

  json.attributes pr, :url, :number, :state, :created_at, :updated_at, :closed_at, :merged_at

  json.links do
    json.user api_user_path(pr.user)
  end
end

