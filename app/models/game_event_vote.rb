class GameEventVote < ActiveRecord::Base
  require Status

  belongs_to :event
  belongs_to :game_event
end
