json.analyses do
  json.array! @analyses do |analysis|
    json.nickname analysis.user.nickname
    json.user_image analysis.user.image
    json.text  analysis.text
    json.school analysis.school.name
    json.title analysis.title
    json.id analysis.id
    json.image analysis.image
    json.time analysis.created_at.strftime("%Y/%m/%d")
  end
end

json.current_user do
  json.current_user current_user.id if current_user.present?
end