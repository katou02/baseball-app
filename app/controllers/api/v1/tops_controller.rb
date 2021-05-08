class Api::V1::TopsController < ApiController
  def index
    @current_user_unchecked = Notification.where(checked: 0,visited_id: current_user.id)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end