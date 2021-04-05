class Api::V1::ForecastsController < ApiController
  before_action :search_forecast,only:[:show,:destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @forecasts = Forecast.all.order(created_at: "DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def new
    @roots = Category.roots
    root_id = params[:root_id]
    child_id = params[:child_id]
    @children = root_id ? @roots.find(root_id).children : []
    @grand_children = child_id ? @children.find(child_id).children : []
    render 'new', formats: 'json', handlers: 'jbuilder'
  end

  def create
    forecast = Forecast.create(forecast_params)
    if forecast.save
      render json: forecast, status: :created
    else
      render json: { errors: forecast.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @current_user = current_user
    @user = User.find_by(id: @forecast.user.id)
    @nickname = current_user.nickname
    render 'show',formats: 'json',handlers: 'jbuilder'
  end

  def destroy
    if @forecast.user_id == current_user.id
      if @forecast.destroy
        head :no_content
      else
        render json: @forecast.errors, status: :unprocessable_entity
      end
    end
  end

  def search_forecast
    @forecast = Forecast.find(params[:id])
  end

  private

  def forecast_params
    params.require(:forecast).permit(:text,:round,:win_school_id,:lose_school_id,:tournament_id,:probability).merge(user_id: current_user.id)
  end
end