json.tweets do
  json.array! @tweets do |tweet|
    json.nickname tweet.user.nickname
    json.text  tweet.text
    json.round tweet.round
    json.school_a tweet.school_a.name
    json.school_b tweet.school_b.name
    json.title tweet.title_info
    json.id tweet.id
    json.image tweet.image
    json.time tweet.created_at.strftime("%Y年%m月%d日")
  end
end

json.current_user do
  json.current_user current_user.id if current_user.present?
end