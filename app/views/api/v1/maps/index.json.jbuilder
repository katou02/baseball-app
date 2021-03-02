json.array! @maps do |map|
  json.nickname map.user.nickname
  json.win_school map.school.name
  json.time map.created_at.strftime("%Y年%m月%d日 %H時%M分")
end