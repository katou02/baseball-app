class Api::V1::UsersController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @users = User.all.order("created_at DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if (@user.id == current_user.id || current_user.admin) && current_user.nickname!="ゲスト" || current_user.admin
      @user.update(user_params)
      head :no_content
    else
      render json: { errors: @user.errors.keys.map { |key| [key, @user.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  def show
    @follower = Relationship.where(following_id: params[:id])
    @follow = Relationship.where(follower_id: params[:id])
    @user = User.find(params[:id])
    @check = current_user.following?(@user)
    @myEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    @my_tweets = @user.tweets.order("created_at DESC")
    @my_analyses = @user.analyses.order("created_at DESC")
    @my_forecasts = @user.forecasts.order("created_at DESC")
    @likes = @user.likes.order("created_at DESC")
    my_likes(@likes)
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

  def following
    @user  = User.find(params[:id])
    @users = @user.followings.order("created_at DESC")
    render 'follow', formats: 'json', handlers: 'jbuilder'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.order("created_at DESC")
    render 'follower', formats: 'json', handlers: 'jbuilder'
  end

  def my_likes(likes)
    my_likes = []
    likes.each do |like|
      my_likes << Tweet.find_by(id: like.tweet_id)
    end
    @my_likes = my_likes
  end

  private
  def user_params
    params.permit(:text,:prefecture,:image)
  end
end