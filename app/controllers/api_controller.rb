class ApiController < ApplicationController
  protect_from_forgery with: :exception
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    if session_exists?(:access)
      @current_user  ||= User.find(payload['user_id'])
    else
      cookie_based_auth(:access)
      @current_user  ||= User.find(payload['user_id'])
    end
  rescue
    nil
  end
  
  def not_authorized
    render json: { error: 'ログインに失敗しました 入力情報を確認してください' }, status: :unauthorized
  end
end