json.type 'user'
json.id user.id

json.attributes user, :login

json.links do
  json.pull_requests user.pull_requests do |pr|
    json.partial! 'api/pull_requests/linkage', pull_request: pr
  end
end

