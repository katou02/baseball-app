json.nickname @map.user.nickname
json.user_image @map.user.image
json.user_id @map.user_id
json.school @map.school.name
json.tournament @map.tournament_id
json.school_id @map.school_id
json.text @map.text
json.image @map.image
json.address @map.address
json.latitude @map.latitude
json.longitude @map.longitude
if current_user
  json.admin current_user.admin
  json.current_user current_user
else
  json.current_user 9999
end
json.time @map.created_at.strftime("%Y年%m月%d日 %H時%M分")