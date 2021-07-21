class Api::V1::AnalysesController < ApiController
  skip_before_action :verify_authenticity_token
  before_action :search_analysis,only:[:show,:destroy,:edit,:update]
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @analyses = Analysis.all.order(created_at: "DESC").includes(:user)
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
      render json: { errors: analysis.errors.keys.map { |key| [key, analysis.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  def edit
    @schools = Category.where(ancestry: @analysis.tournament_id)
    render 'edit', formats: 'json', handlers: 'jbuilder'
  end
  
  def update
    if (@analysis.user_id == current_user.id || current_user.admin) && @analysis.update(update_params) 
        head :no_content
    else
      render json: { errors: @analysis.errors.keys.map { |key| [key, @analysis.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(id: @analysis.user.id)
    @num = 1
    render 'show',formats: 'json',handlers: 'jbuilder'
  end

  def destroy
    if (@analysis.user_id == current_user.id || current_user.admin) && @analysis.destroy
      head :no_content
    else
      render json: @analysis.errors, status: :unprocessable_entity
    end
  end

  def search_analysis
    @analysis = Analysis.find(params[:id])
  end

  private

  def analysis_params
    params.permit(:title,:text,:tournament_id,:school_id,:attack,:defensive,:pitcher,:comprehensive,:expectations,:image).merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:title,:text,:school_id,:attack,:defensive,:pitcher,:comprehensive,:expectations,:image)
  end
end