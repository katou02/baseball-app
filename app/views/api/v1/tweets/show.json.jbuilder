json.text @tweet.text
json.tournament @tweet.tournament.name
json.nickname @tweet.user.nickname
json.school_a @tweet.school_a.name
json.school_a_id @tweet.school_a.id
json.school_b @tweet.school_b.name
json.school_b_id @tweet.school_b.id
json.school_a_score @tweet.school_a_score
json.school_b_score @tweet.school_b_score
json.title @tweet.title_info
json.tweet_image @tweet.image
json.id @tweet.id
json.user_id @tweet.user.id
json.user_image @tweet.user.image
json.time @tweet.created_at.strftime("%Y年%m月%d日 %H時%M分")
if @current_user.present?
  json.admin current_user.admin
  json.current_user @current_user.id
  json.like @like
end
json.like_count @likes.count