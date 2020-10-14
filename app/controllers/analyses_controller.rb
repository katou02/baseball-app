class AnalysesController < ApplicationController
  before_action :set_category, only:[:new]
  def index
  end

  def new
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end
end
