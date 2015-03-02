class GameEventVote < ActiveRecord::Base
  include Status

  belongs_to :event
  belongs_to :game_event
end
