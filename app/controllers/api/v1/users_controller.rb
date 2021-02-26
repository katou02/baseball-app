class Api::V1::UsersController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @users = User.all.order("created_at DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end