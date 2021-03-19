json.array! @comments do |comment|
  json.comment comment.text
  json.comment_nickname comment.user.nickname
  json.time comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
end