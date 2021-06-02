class Api::V1::MessagesController < ApiController
  protect_from_forgery
  # before_action :authenticate_user!

  def create
    @room = Entry.where(room_id: params[:room_id]).where.not(user_id: current_user.id)
    @user = User.find_by(id: @room[0].user_id)
    @check = current_user.following?(@user)
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present? && @check.present?
      @message = Message.new(message_params)
      @room=@message.room

      if @message.save
        render json: @message,status: :created
        @roommembernotme=Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
        @theid=@roommembernotme.find_by(room_id: @room.id)
        notification = current_user.active_notifications.new(
            room_id: @room.id,
            message_id: @message.id,
            visited_id: @theid.user_id,
            visiter_id: current_user.id,
            action: 'dm'
        )
        if notification.visiter_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?

      else
        render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
      end
      
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def message_params
    # params.require(:message).permit(:body,:room_id).merge(user_id: current_user.id)
    params.require(:message).permit(:user_id, :body, :room_id).merge(user_id: current_user.id)
  end
end