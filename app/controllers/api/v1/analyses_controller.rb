class Api::V1::AnalysesController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @analyses = Analysis.all.order(created_at: "DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end