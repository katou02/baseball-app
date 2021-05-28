json.text @forecast.text
json.tournament @forecast.tournament.name
json.nickname @forecast.user.nickname
json.win_school @forecast.win_school.name
json.win_school_id @forecast.win_school_id
json.lose_school @forecast.lose_school.name
json.lose_school_id @forecast.lose_school.id
json.round @forecast.round
json.probability @forecast.probability
json.id @forecast.id
json.user_id @forecast.user.id
json.user_image @forecast.user.image
json.time @forecast.created_at.strftime("%Y年%m月%d日 %H時%M分")
if current_user.present?
  json.admin current_user.admin
  json.current_user current_user.id
end