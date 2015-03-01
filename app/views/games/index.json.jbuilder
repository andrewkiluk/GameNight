json.array!(@games) do |game|
  json.extract! game, :id, :title, :last_sync
  json.url game_url(game, format: :json)
end
