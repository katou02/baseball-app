class ForecastsController < ApplicationController
  before_action :set_category, only: [:new]

  def index
  end

  def new
    @forecast = Forecast.new
    respond_to do |format|
      format.html
      format.json do
      @category_children = Category.find(params[:tournament_id]).children
      end
    end
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end
end
