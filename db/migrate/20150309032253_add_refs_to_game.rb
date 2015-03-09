class AddRefsToGame < ActiveRecord::Migration
  def change
    add_reference :games, :library_games, references: :library_games, index: true
  end
end
