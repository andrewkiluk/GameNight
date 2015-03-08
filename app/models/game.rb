class Game < ActiveRecord::Base
	include Status

   has_many :libraries, through: :library_games
   has_many :events, through: :game_events

   attr_accessor :title
   attr_accessor :last_sync
   attr_accessor :bgg_gameId
   attr_accessor :bgg_minPlayers
   attr_accessor :bgg_maxPlayers
   attr_accessor :bgg_bggRating
   attr_accessor :bgg_image
   attr_accessor :bgg_thumbnail
   attr_accessor :bgg_playingTime
   attr_accessor :bgg_rank

end
