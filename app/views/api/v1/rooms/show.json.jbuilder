json.message do
  json.array! @messages
end

json.member do
  json.array! @member,:user
end
json.current_user @current_user

# json.array! @member do |member|
#   json.user member.user.nickname
# end