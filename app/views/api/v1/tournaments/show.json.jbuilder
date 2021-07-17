json.tweets do
  json.array! @tweets do |tweet|
    json.nickname tweet.user.nickname
    json.user_image tweet.user.image
    json.round tweet.round
    json.text  tweet.text
    json.school_a tweet.school_a.name
    json.school_b tweet.school_b.name
    json.title tweet.title
    json.tournament tweet.tournament.name
    json.id tweet.id
    json.image tweet.image
    json.time tweet.created_at.strftime("%Y/%m/%d")
  end
end

json.current_user do
  json.current_user current_user.id if current_user.present?
end