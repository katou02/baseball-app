json.schools do
  json.array! @schools do |school|
    json.name school.name
    json.id school.id
  end
end
json.current_user current_user
json.user_id @analysis.user_id