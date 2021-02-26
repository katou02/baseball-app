json.array! @users do |user|
  json.name user.nickname
  json.text user.text
  json.prefecture user.prefecture
  json.image user.image
end