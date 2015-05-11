json.data do
  json.partial! 'api/users/primary', collection: @users, as: :user
end

