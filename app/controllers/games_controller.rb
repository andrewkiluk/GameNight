class GamesController < ApplicationController

  def index
    unless @current_user.library_id
      flash[:error] = "This account has no associated game library!"
      @games = []
      render and return
    end

    @games = Game.by_user(@current_user)

  end


  def show
    bgg_id = params[:bgg_id]

    @game = Game.where(bgg_id: bgg_id).first

    @owners = Game.owners(bgg_id)

    response = Game.bgg_show(bgg_id)
  end


  def search
  end


  def search_action
    search_string = params[:search_string]
    response = Game.bgg_search(search_string)
    @games = response['items']['item'] ? response['items']['item'] : []
    @owned_game_bgg_ids = Game.by_user(@current_user).map { |game| game.bgg_id.to_s }
    logger.info '************************'
    logger.info @owned_game_bgg_ids
    logger.info '************************'
  end


  def add
    bgg_id = params[:bgg_id]
    game_in_db = Game.where("bgg_id = ?", bgg_id).first
    if game_in_db
      @game = game_in_db
    else
      bgg_data = Game.bgg_show(bgg_id)['items']['item']
      @game = Game.create_from_bgg(bgg_data)
    end

    LibraryGame.create(library: @current_user.library, game: @game)

    render text: 'success'

  end


  def delete
    bgg_id = params[:bgg_id]
    @game = Game.where(bgg_id: bgg_id).first
    LibraryGame.where(library: @current_user.library, game: @game).destroy_all

    render text: 'success'
  end

end
