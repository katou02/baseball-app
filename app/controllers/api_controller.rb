class ApiController < ApplicationController
  # before_action :authorize_access_request!,except: :index
  # before_action lambda{ cookie_based_auth(:access) }
  protect_from_forgery with: :exception
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    if session_exists?(:access)
      @current_user  ||= User.find(payload['user_id'])
    else
      cookie_based_auth(:access)
      logger.info("else")
      @current_user  ||= User.find(payload['user_id'])
    end
  rescue => e
    logger.warn(e)
    logger.warn(e.backtrace.join("\n"))
    nil
  end
  
  def not_authorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end