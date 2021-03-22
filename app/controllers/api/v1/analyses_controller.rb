class Api::V1::AnalysesController < ApiController
  before_action :search_analysis,only:[:show,:destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @analyses = Analysis.all.order(created_at: "DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def category
    @category = Category.where(ancestry: nil)
    render 'category',formats: 'json',handlers: 'jbuilder'
  end

  def show
    @current_user = current_user
    # @analysis = Analysis.find(params[:id])
    @user = User.find_by(id: @analysis.user.id)
    @nickname = current_user.nickname
    @num = 1
    # gon.data = []
    # gon.data.push(@analysis.attack,@analysis.defensive,@analysis.pitcher,@analysis.comprehensive,@analysis.expectations)
    render 'show',formats: 'json',handlers: 'jbuilder'
  end

  def destroy
    if @analysis.destroy
      head :no_content
    else
      render json: @analysis.errors, status: :unprocessable_entity
    end
  end

  def search_analysis
    @analysis = Analysis.find(params[:id])
  end
end