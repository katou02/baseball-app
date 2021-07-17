json.forecasts do
  json.array! @forecasts do |forecast|
    json.nickname forecast.user.nickname
    json.user_image forecast.user.image
    json.round  forecast.round
    json.win_school forecast.win_school.name
    json.lose_school forecast.lose_school.name
    json.id forecast.id
    json.time forecast.created_at.strftime("%Y/%m/%d")
  end
end

json.current_user do
  json.current_user current_user.id if current_user.present?
end