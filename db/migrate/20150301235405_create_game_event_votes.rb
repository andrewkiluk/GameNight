class CreateGameEventVotes < ActiveRecord::Migration
  def change
    create_table :game_event_votes do |t|

      t.timestamps null: false
    end
  end
end
