json.array!(@rooms) do |room|
  json.extract! room, :id, :openHour, :closeHour
  json.url room_url(room, format: :json)
end
