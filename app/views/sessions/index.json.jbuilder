json.array!(@sessions) do |session|
  json.extract! session, :id, :bandName, :sessionDate, :sessionTime, :sessionLength, :comments
  json.url session_url(session, format: :json)
end
