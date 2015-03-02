class CreateGameEvents < ActiveRecord::Migration
  def change
    create_table :game_events do |t|

      t.timestamps null: false
    end
  end
end
