# json.array! @schools do |school|
#   json.school school
# end


json.school do
  json.array! @schools
end

json.vote do
  json.array! @vote
end

# json.my_champion @my_champion.champion_school.name
json.set! :my_champion do
  if @my_champion.present?
    json.school @my_champion.champion_school.name
    json.id @my_champion.id
  end
end

json.select_schools do
  json.array! @select_schools
end