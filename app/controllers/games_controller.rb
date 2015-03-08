class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]


  #require 'json'
  #require 'net/http'
  #s = Net::HTTP.get_response(URI.parse('http://stackoverflow.com/feeds/tag/ruby/')).body
  #Hash.from_xml(s).to_json

  # GET /games
  # GET /games.json
  def index
    @games = Game.where("")

    @current_user.id
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :last_sync)
    end
end
