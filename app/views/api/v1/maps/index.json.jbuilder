json.array! @maps do |map|
  json.nickname map.user.nickname
  json.image map.user.image
  json.school map.school.name
  json.id map.id
  json.time map.created_at.strftime("%Y年%m月%d日 %H時%M分")
end