json.users do
  json.array! @users do |user|
    json.name user.nickname
    json.text user.text
    json.prefecture user.prefecture
    json.image user.image
    json.id user.id
  end
end
json.current_user current_user.id if current_user.present?