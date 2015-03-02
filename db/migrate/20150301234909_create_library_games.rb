class CreateLibraryGames < ActiveRecord::Migration
  def change
    create_table :library_games do |t|

      t.timestamps null: false
    end
  end
end
