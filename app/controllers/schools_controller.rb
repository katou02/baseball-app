class SchoolsController < ApplicationController
  def new
    @school = School.new
  end

  def create
    @school = School.create(name: name_params[:name],tournament_id: name_params[:tournament_id])
    if @school.save
      redirect_to action: :new
    else
      render "new"
    end
  end

  def show
    @tweets = Tweet.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  private
  def name_params
    params.require(:school).permit(:name,:tournament_id)
  end
end
