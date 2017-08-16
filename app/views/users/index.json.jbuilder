json.array!(@users) do |user|
  json.id user.id
  json.name user.username

  json.extract! user,:id,:username
  json.url user_url(user)
end