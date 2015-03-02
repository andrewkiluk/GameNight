class AddRefsToGameEventVote < ActiveRecord::Migration
  def change
    add_reference :game_event_votes, :event, references: :events, index: true
    add_reference :game_event_votes, :game_event, references: :game_events, index: true
    add_reference :game_event_votes, :user, references: :users, index: true
  end
end
