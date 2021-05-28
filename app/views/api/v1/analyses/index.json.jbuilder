json.analyses do
  json.array! @analyses do |analysis|
    json.nickname analysis.user.nickname
    json.text  analysis.text
    json.school analysis.school.name
    json.title analysis.title
    json.id analysis.id
    json.image analysis.image
    json.time analysis.created_at.strftime("%Y年%m月%d日")
  end
end

json.current_user do
  json.current_user current_user.id if current_user.present?
end