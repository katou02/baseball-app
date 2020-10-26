module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_item = link_to 'あなたの投稿', tweets_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    case notification.action
      when "follow" then
        tag.a(notification.visiter.nickname, href:users_user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.nickname, href:mypage_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.tweet_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visiter_comment)
          tag.a(@visiter.nickname, href:mypage_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.tweet_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
