module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @message = nil
    @comment_analysis = nil
    your_item = link_to 'あなたの投稿', tweets_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    @message_comment = notification.message_id
    @analysis_comment = notification.comment_analysis_id
    case notification.action
      when "follow" then
        tag.a(notification.visiter.nickname, href:mypage_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.nickname, href:mypage_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.tweet_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
        @comment = Comment.find_by(id: @visiter_comment)
        tag.a(@visiter.nickname, href:mypage_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.tweet_id), style:"font-weight: bold;")+"にコメントしました"
      when "dm" then
        @message = Message.find_by(id: @visiter_message)
        tag.a(@visiter.nickname, href:mypage_path(@visiter), style:"font-weight: bold;")+"があなたに"+tag.a('ダイレクトメッセージ', href:room_path(notification.room_id), style:"font-weight: bold;")+"を送りました"
      when "comment_analysis"
        @comment_analysis = CommentAnalysis.find_by(id: @analysis_comment)
        tag.a(@visiter.nickname, href:mypage_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:analysis_path(notification.analysis_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end
  
  def unchecked_notifications
    if user_signed_in?
      @notifications = current_user.passive_notifications.where(checked: false)
    end
  end
end
