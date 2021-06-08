class Api::V1::SessionsController < ApiController
  before_action :authorize_access_request!, only: [:destroy]
  protect_from_forgery except: [:create, :destroy]

  def create
    user = User.find_by!(email: params[:email])
    # binding.pry
    if user.valid_password?(params[:password])
      payload = { user_id: user.id }
      logger.info("第1")
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      logger.info("第2")
      tokens = session.login
      logger.info("第3")
      response.set_cookie(JWTSessions.access_cookie,
                        value: tokens[:access],
                        httponly: true,
                        secure: Rails.env.production?)
      render json: { csrf: tokens[:csrf] }
      logger.info("ログイン成功")
    else
      logger.info("ログインelse")
      not_authorized
    end
  end

  def destroy
    logger.info("ログアウト第1")
    session = JWTSessions::Session.new(payload: payload)
    logger.info("ログアウト第２")
    session.flush_by_access_payload
    logger.info("ログアウト第3")
    response.delete_cookie(JWTSessions.access_cookie)
    logger.info("ログアウト第4")
    render json: :ok
  end

  private

  def not_found
    render json: { error: "Cannot find email/password combination" }, status: :not_found
  end
end
