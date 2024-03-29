class Api::V1::ForecastsController < ApiController
  skip_before_action :verify_authenticity_token
  before_action :search_forecast,only:[:show,:destroy,:edit,:update]
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @forecasts = Forecast.all.order(created_at: "DESC").includes(:user)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def new
    @current_user = current_user.id if current_user.present?
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
      render json: { errors: forecast.errors.keys.map { |key| [key, forecast.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  def edit
    @schools = Category.where(ancestry: @forecast.tournament_id)
    render 'edit', formats: 'json', handlers: 'jbuilder'
  end
  
  def update
    if (@forecast.user_id == current_user.id || current_user.admin) && @forecast.update(update_params) 
        head :no_content
    else
      render json: { errors: @forecast.errors.keys.map { |key| [key, @forecast.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  def show
    @current_user = current_user
    @user = User.find_by(id: @forecast.user.id)
    render 'show',formats: 'json',handlers: 'jbuilder'
  end

  def destroy
    if (@forecast.user_id == current_user.id || current_user.admin) && @forecast.destroy
      head :no_content
    else
      render json: @forecast.errors, status: :unprocessable_entity
    end
  end

  def search_forecast
    @forecast = Forecast.find(params[:id])
  end

  private

  def forecast_params
    params.require(:forecast).permit(:text,:round,:win_school_id,:lose_school_id,:tournament_id,:probability).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:forecast).permit(:text,:round,:win_school_id,:lose_school_id,:tournament_id,:probability)
  end
end