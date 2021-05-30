class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    include JWTSessions::RailsAuthorization
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    end

    private

    # def current_user
    #   @current_user ||= User.find(payload['user_id'])
    # end
  
    def not_authorized
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
end
