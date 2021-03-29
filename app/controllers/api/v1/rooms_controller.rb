class Api::V1::RoomsController < ApiController

  def index
    @currentEntries = current_user.entries
    myRoomIds = []
  
    @currentEntries.each do | entry |
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(user_id: current_user.id)
    render 'index', formats: 'json', handlers: 'jbuilder'
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
  end
end