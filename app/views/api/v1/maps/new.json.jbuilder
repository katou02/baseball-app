json.school do
  json.array! @school
end
json.tournament @tournament.name
json.current_user @current_user