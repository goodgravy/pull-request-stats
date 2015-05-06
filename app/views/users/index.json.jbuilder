json.array!(@users) do |user|
  json.extract! user, :id, :id, :login
  json.url user_url(user, format: :json)
end
