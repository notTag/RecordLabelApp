json.array!(@studios) do |studio|
  json.extract! studio, :id, :studioName, :lunchHours, :numberRooms
  json.url studio_url(studio, format: :json)
end
