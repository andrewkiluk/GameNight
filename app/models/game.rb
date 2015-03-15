class Game < ActiveRecord::Base
	include Status
  require 'net/http'
  require 'erb'

  has_many :library_games
  has_many :libraries, through: :library_games
  has_many :game_events
  has_many :events, through: :game_events



  # Search the BoardGameGeek database for games
  def self.bgg_search(unencoded_search_string)

    search_string = ERB::Util.url_encode(unencoded_search_string)

    url_string = 'http://www.boardgamegeek.com/xmlapi2/search?query=' + search_string
    Game.api_request(url_string)

  end

  # Retrieve data from BoardGameGeek about a game
  def self.bgg_show(bgg_id)

    url_string = 'http://www.boardgamegeek.com/xmlapi2/thing?stats=1&id=' + bgg_id
    Game.api_request(url_string)

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