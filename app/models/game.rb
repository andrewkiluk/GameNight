class Game < ActiveRecord::Base
	include Status
  require 'net/http'
  require 'open-uri'

  has_many :library_games
  has_many :libraries, through: :library_games
  has_many :game_events
  has_many :events, through: :game_events




  def self.bgg_search(unsafe_search_string)

    search_string = URI::www_form_encode_component(unsafe_search_string)

    url_string = 'http://www.boardgamegeek.com/xmlapi2/search?query=' + search_string
    Game.api_request(url_string)

  end


  def self.bgg_show(bgg_id)

    url_string = 'http://www.boardgamegeek.com/xmlapi2/thing?id=' + bgg_id
    Game.api_request(url_string)

  end


  def self.api_request(url)
    url = URI.parse(url_string)
    request = Net::HTTP::Get.new(url.to_s)
    response = Net::HTTP.start(url.host, url.port) {|http|
      http.request(request)
    }
    Hash.from_xml(response.body)
  end


end