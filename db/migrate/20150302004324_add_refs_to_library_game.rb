class AddRefsToLibraryGame < ActiveRecord::Migration
  def change
    add_reference :library_games, :library, index: true
    add_reference :library_games, :game, index: true
  end
end
