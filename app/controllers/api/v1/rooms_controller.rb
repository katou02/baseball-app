class Api::V1::RoomsController < ApiController
  protect_from_forgery
  
  def index
    @currentEntries = current_user.entries
    myRoomIds = []
  
    @currentEntries.each do | entry |
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(user_id: current_user.id).order(id: "DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    @room = Room.create
    Entry.create(room_id: @room.id,user_id: current_user.id)
    Entry.create(params.permit(:user_id,:room_id).merge(room_id: @room.id))
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.all
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
    @member=@entries.where.not(user_id: current_user.id)
    @user = User.find_by(id: @member[0].user_id)
    @check = current_user.following?(@user)
    @current_user = User.find_by(id: current_user.id)
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end