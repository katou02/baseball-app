class TopController < ApplicationController
  def index
  end

  def choose
    @tournaments = Tournament.order("id DESC")
  end
end
