# json.array! @notifications do |notification|
#   json.tweet notification.tweet_id
#   json.analysis notification.analysis_id
#   json.forecast notification.forecast_id
#   json.room notification.room_id
#   json.message notification.message_id
#   json.comment notification.comment_id
#   json.comment_analysis notification.comment_analysis_id
#   json.comment_forecast notification.comment_forecast_id
#   json.action notification.action
# end
json.notification do
  json.array! @notifications
end

json.check do
  json.array! @check
end