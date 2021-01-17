class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:success] = "Created The Board"
      redirect_to @game
    else
      render 'new'
    end
  end

  def index
    @games = Game.all
  end

  def show
    @user = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:title, :description, :game_image)
  end
end
