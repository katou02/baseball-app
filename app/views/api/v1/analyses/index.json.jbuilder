json.array! @analyses do |analysis|
  json.nickname analysis.user.nickname
  json.text  analysis.text
  json.school analysis.school
  json.title analysis.title
  json.id analysis.id
  json.time analysis.created_at.strftime("%Y年%m月%d日 %H時%M分")
  # json.total_page @total_pages
end