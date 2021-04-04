class Api::V1::AnalysesController < ApiController
  before_action :search_analysis,only:[:show,:destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @analyses = Analysis.all.order(created_at: "DESC")
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
    analysis = Analysis.create(analysis_params)
    if analysis.save
      render json: analysis, status: :created
    else
      render json: { errors: analysis.errors.full_messages }, status: :unprocessable_entity
    end
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
    if @analysis.user_id == current_user.id
      if @analysis.destroy
        head :no_content
      else
        render json: @analysis.errors, status: :unprocessable_entity
      end
    end
  end

  def search_analysis
    @analysis = Analysis.find(params[:id])
  end

  private

  def analysis_params
    params.require(:analysis).permit(:title,:text,:tournament_id,:school_id,:attack,:defensive,:pitcher,:comprehensive,:expectations).merge(user_id: current_user.id)
  end
end