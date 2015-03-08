class Game < ActiveRecord::Base
	include Status

   has_many :libraries, through: :library_games
   has_many :events, through: :game_events

end
