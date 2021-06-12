json.unchecked do
  json.array! @current_user_unchecked
end

json.current_user do
  json.current_user current_user.id if current_user.present?
end