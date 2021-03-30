# json.array! @schools do |school|
#   json.school school
# end

# json.array! @vote do |vote|
#   json.vote vote
# end

json.school do
  json.array! @schools
end

json.vote do
  json.array! @vote
end

json.my_champion @my_champion.champion_school.name