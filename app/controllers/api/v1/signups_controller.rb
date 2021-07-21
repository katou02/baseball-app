class Api::V1::SignupsController < ApplicationController
  protect_from_forgery except: [:create]

  def create
    user = User.new(user_params)
    if user.save
      payload  = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: false)
      render json: { csrf: tokens[:csrf] }
    else
      render json: { errors: user.errors.keys.map { |key| [key, user.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:nickname, :email, :password, :password_confirmation)
  end
end
