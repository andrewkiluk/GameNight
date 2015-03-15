class GamesController < ApplicationController

  def index
    library_id = @current_user.library_id
    if library_id
      @games = Game
        .joins(:libraries)
        .where("library_id = ?", library_id)
    else
      flash[:error] = "This account has no associated game library!"
      @games = []
    end

  end


  def show
    bgg_id = params[:bgg_id]
    response = Game.bgg_show(bgg_id)
    render text: response.to_json
  end


  def search

  end


  def search_action
    search_string = params[:search_string]
    response = Game.bgg_search(search_string)
    render text: response
  end


  def add
    bgg_id = params[:bgg_id]
    game_in_db = Game.find(bgg_id: bgg_id)
    if game_in_db
      @game = game_in_db
    else
      bgg_data = Game.bgg_show(bgg_id)
      @game = Game.create_from_bgg(bgg_data)
    end

    LibraryGame.create(library: @current_user.library, game: @game)

    render text: success

  end


  def delete
    bgg_id = params[:bgg_id]
    @game = Game.find(bgg_id: bgg_id)
    LibraryGame.destroy(library: @current_user.library, game: @game)

    render text: success
  end

end
