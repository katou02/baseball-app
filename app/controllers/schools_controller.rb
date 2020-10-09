class SchoolsController < ApplicationController
  def new
    @school = School.new
    @schools = School.all
  end

  def create
    @school = School.create(name_params)
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
    params.require(:school).permit(:name, :tournament_ids)
  end
end