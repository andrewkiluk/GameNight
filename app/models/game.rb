class Game < ActiveRecord::Base
	include Status
  require 'net/http'
  require 'erb'

  has_many :library_games
  has_many :libraries, through: :library_games
  has_many :game_events
  has_many :events, through: :game_events


  def self.owners(bgg_id)
    User
      .joins('INNER JOIN libraries l ON l.id = users.library_id')
      .joins('INNER JOIN library_games lg ON lg.library_id = l.id')
      .joins('INNER JOIN games g ON lg.game_id = g.id')
      .where("g.bgg_id = ?", bgg_id)
      .first(500)
  end


  def self.by_user(user)
    unless user && user.library_id
      return []
    end

    Game
      .joins(:libraries)
      .where("library_id = ?", user.library_id)
      .order("games.title")
  end


  def self.create_from_bgg(bgg_data)
    bgg_rank = 0
    begin
      bgg_rank = bgg_data['statistics']['ratings']['ranks']['rank']
                    .select{ |ranking| ranking['name'] == 'boardgame'}[0]['value']
    rescue
      bgg_rank = ""
    end
    game_title = bgg_data['name']

    if game_title.is_a?(Array)
      game_title = game_title.select{ |name| name['type'] == 'primary' }[0]['value']
    else
      game_title = game_title['value']
    end

    game_data = {
      title: game_title,
      bgg_id: bgg_data['id'],
      bgg_rating: bgg_data['statistics']['ratings']['average']['value'],
      bgg_rank: bgg_rank,
      bgg_min_players: bgg_data['minplayers']['value'],
      bgg_max_players: bgg_data['maxplayers']['value'],
      bgg_image: bgg_data['image'],
      bgg_playing_time: bgg_data['playingtime']['value']
    }

    Game.create(game_data)

  end


  # Search the BoardGameGeek database for games
  def self.bgg_search(unencoded_search_string)

    search_string = ERB::Util.url_encode(unencoded_search_string)

    url_string = 'http://www.boardgamegeek.com/xmlapi2/search?type=boardgame&query=' + search_string
    Game.api_request(url_string)

  end

  # Retrieve data from BoardGameGeek about a game
  def self.bgg_show(bgg_id)

    url_string = 'http://www.boardgamegeek.com/xmlapi2/thing?stats=1&id=' + bgg_id
    Game.api_request(url_string)['items']['item']

  end

  # Wrapper for making API requests
  def self.api_request(url_string)
    url = URI.parse(url_string)
    request = Net::HTTP::Get.new(url.to_s)
    response = Net::HTTP.start(url.host, url.port) {|http|
      http.request(request)
    }
    Hash.from_xml(response.body)
  end

end