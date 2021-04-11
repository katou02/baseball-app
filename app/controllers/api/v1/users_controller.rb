class Api::V1::UsersController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @users = User.all.order("created_at DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @follower = Relationship.where(following_id: params[:id])
    @follow = Relationship.where(follower_id: params[:id])
    @user = User.find(params[:id])
    @check=current_user.following?(@user)
    @user_id = @user.id
    @likes = Like.where(user_id: @user.id)
    @myEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    @my_tweets = @user.tweets.order("created_at DESC")
    @my_analyses = @user.analyses.order("created_at DESC")
    @my_forecasts = @user.forecasts.order("created_at DESC")
    @likes = @user.likes.page(params[:page]).per(5).order("created_at DESC")
    if @user.id == current_user.id
    else
      @myEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      if @isRoom != true
        @room = Room.new
        @entry = Entry.new
      end
    end
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end