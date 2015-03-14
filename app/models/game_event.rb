class GameEvent < ActiveRecord::Base
  require Status

  belongs_to :game
  belongs_to :event
  has_many :game_event_votes
end
