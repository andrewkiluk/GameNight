class GameEvent < ActiveRecord::Base
  include Status

  belongs_to :game
  belongs_to :event
  has_many :game_event_votes
end
