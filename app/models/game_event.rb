class GameEvent < ActiveRecord::Base
  include Status

  has_many :game_event_votes
end
