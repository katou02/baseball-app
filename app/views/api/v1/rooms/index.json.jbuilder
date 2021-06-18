json.entry do
  json.array! @anotherEntries do |entry|
    json.user entry.user.nickname
    json.user_image entry.user.image
    json.room_id entry.room_id
  end
end
json.current_user current_user