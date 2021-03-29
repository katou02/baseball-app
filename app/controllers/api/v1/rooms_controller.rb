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
end