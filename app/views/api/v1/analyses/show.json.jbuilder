json.text @analysis.text
json.tournament @analysis.tournament.name
json.nickname @analysis.user.nickname
json.school @analysis.school.name
json.school_id @analysis.school.id
json.title @analysis.title
json.id @analysis.id
json.user_id @analysis.user.id
json.user_image @analysis.user.image
json.fcs_image @analysis.image
json.time @analysis.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.attack @analysis.attack
json.defensive @analysis.defensive
json.pitcher @analysis.pitcher
json.comprehensive @analysis.comprehensive
json.expectations @analysis.expectations
if current_user.present?
  json.admin current_user.admin
  json.current_user current_user.id
end