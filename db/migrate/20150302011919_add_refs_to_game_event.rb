class AddRefsToGameEvent < ActiveRecord::Migration
  def change
    add_reference :game_events, :game, index: true
    add_reference :game_events, :event, index: true
  end
end
