class AddBggDataToGame < ActiveRecord::Migration
  def change
    add_column :games, :bgg_gameId, :integer
    add_column :games, :bgg_minPlayers, :integer
    add_column :games, :bgg_maxPlayers, :integer
    add_column :games, :bgg_bggRating, :float
    add_column :games, :bgg_image, :string
    add_column :games, :bgg_thumbnail, :string
    add_column :games, :bgg_playingTime, :integer
    add_column :games, :bgg_rank, :integer
  end
end
