json.array!(@users) do |user|
  json.extract! user, :id, :type, :name, :contactNumber
  json.url user_url(user, format: :json)
end
