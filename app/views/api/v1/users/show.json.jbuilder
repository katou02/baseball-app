json.id @user.id
json.nickname @user.nickname
json.image @user.image
json.prefecture @user.prefecture
json.text @user.text
json.follow @follow
json.follower @follower
json.follow_count @follow.count
json.follower_count @follower.count
json.check @check
json.current_user @current
json.room @isRoom
json.room_id @roomId

json.set! :tweet do
  json.array! @my_tweets do |tweet|
    json.nickname tweet.user.nickname
    json.text  tweet.text
    json.school_a tweet.school_a.name
    json.school_b tweet.school_b.name
    json.title tweet.title_info
    json.id tweet.id
    json.time tweet.created_at.strftime("%Y年%m月%d日 %H時%M分")
  end
end

json.set! :analysis do
  json.array! @my_analyses do |analysis|
    json.nickname analysis.user.nickname
    json.text  analysis.text
    json.school analysis.school.name
    json.title analysis.title
    json.id analysis.id
    json.time analysis.created_at.strftime("%Y年%m月%d日 %H時%M分")
  end
end

json.set! :forecast do
  json.array! @my_forecasts do |forecast|
    json.nickname forecast.user.nickname
    json.round  forecast.round
    json.win_school forecast.win_school.name
    json.lose_school forecast.lose_school.name
    json.id forecast.id
    json.time forecast.created_at.strftime("%Y年%m月%d日 %H時%M分")
  end
end

json.likes do
  json.array! @likes
end

json.entry do
  json.array! @myEntry
end

json.userEntry do
  json.array! @userEntry
end