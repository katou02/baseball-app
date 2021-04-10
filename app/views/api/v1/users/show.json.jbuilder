json.id @user.id
json.nickname @user.nickname
json.image @user.image
json.prefecture @user.prefecture
json.text @user.text

json.tweet do
  json.array! @my_tweets
end

json.analysis do
  json.array! @my_analyses
end

json.forecast do
  json.array! @my_forecasts
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