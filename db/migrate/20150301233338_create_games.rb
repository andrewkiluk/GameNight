class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :title
      t.datetime :last_sync

      t.timestamps null: false
    end
  end
end
