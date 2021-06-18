json.message do
  # json.array! @messages
  json.array! @messages do |message|
    json.id message.id
    json.user_id message.user_id
    json.room_id message.room_id
    json.body message.body
    json.time message.created_at.strftime("%Y年%m月%d日 %H時%M分")
  end
end

json.member do
  json.array! @member,:user
end
json.current_user current_user
json.check @check