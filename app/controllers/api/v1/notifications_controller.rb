class Api::V1::NotificationsController < ApiController
  def index
    if current_user.present?
      @notifications = Notification.where(visited_id: current_user.id)
      @check = @notifications.where(checked: false)
      @check.each do |notification|
          notification.update_attributes(checked: true)
      end
    end
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end