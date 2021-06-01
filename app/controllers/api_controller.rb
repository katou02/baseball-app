class ApiController < ApplicationController
  before_action :authorize_access_request!,except: :index
  include JWTSessions::RailsAuthorization
  # rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    # return unless request.headers.include? "Authorization"
    @current_user ||= User.find(payload['user_id'])
  end
  
  def not_authorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end