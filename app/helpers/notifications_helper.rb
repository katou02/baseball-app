module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @message = nil
    @comment_analysis = nil
    @comment_forecast = nil
    your_item = link_to 'あなたの投稿', tweets_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    @message_comment = notification.message_id
    @analysis_comment = notification.comment_analysis_id
    @forecast_comment = notification.comment_forecast_id
    case notification.action
      when "follow" then
        tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold; color: #007bff")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.nickname, href:user_path(@visiter), style:"font-weight: bold; color: #007bff")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.tweet_id), style:"font-weight: bold; color: #007bff")+"にいいねしました"
      when "comment" then
        @comment = Comment.find_by(id: @visiter_comment)
        tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold; color: #007bff")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.tweet_id), style:"font-weight: bold; color: #007bff")+"にコメントしました"
      when "dm" then
        @message = Message.find_by(id: @visiter_message)
        tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold; color: #007bff")+"があなたに"+tag.a('ダイレクトメッセージ', href:room_path(notification.room_id), style:"font-weight: bold; color: #007bff")+"を送りました"
      when "comment_analysis"
        @comment_analysis = CommentAnalysis.find_by(id: @analysis_comment)
        tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold; color: #007bff")+"が"+tag.a('あなたの投稿', href:analysis_path(notification.analysis_id), style:"font-weight: bold; color: #007bff")+"にコメントしました"
      when "comment_forecast"
        @comment_forecast = CommentForecast.find_by(id: @forecast_comment)
        tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold; color: #007bff")+"が"+tag.a('あなたの投稿', href:forecast_path(notification.forecast_id), style:"font-weight: bold; color: #007bff")+"にコメントしました"
    end
  end
  
  def unchecked_notifications
    if user_signed_in?
      @notifications = current_user.passive_notifications.where(checked: false)
    end
  end
end
