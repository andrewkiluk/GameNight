class AddBggDataToGame < ActiveRecord::Migration
  def change
    add_column :games, :bgg_id, :integer
    add_column :games, :bgg_min_players, :integer
    add_column :games, :bgg_max_players, :integer
    add_column :games, :bgg_rank, :integer
    add_column :games, :bgg_rating, :float
    add_column :games, :bgg_image, :string
    add_column :games, :bgg_playing_time, :integer
  end
end
