class Api::V1::NotificationsController < ApiController
  def index
      # @notifications = current_user.passive_notifications.page(params[:page]).per(10).order("created_at DESC")
      @notifications = Notification.where(visited_id: current_user.id)
      @check = @notifications.where(checked: false)
      @notifications.where(checked: false).each do |notification|
          notification.update_attributes(checked: true)
      end
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end