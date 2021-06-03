class Api::V1::TopsController < ApiController
  skip_before_action :verify_authenticity_token
  def index
    @current_user_unchecked = Notification.where(checked: 0,visited_id: current_user.id) if current_user.present?
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end