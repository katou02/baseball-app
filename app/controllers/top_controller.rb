class TopController < ApplicationController
  def index
  end

  def show
    @tournaments = Tournament.order("id DESC")
  end
end
