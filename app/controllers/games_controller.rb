class GamesController < ApplicationController
  # index,edit,update,destroyアクションはログイン状態でしか機能しない
  before_action :logged_in_user, only: [:new, :create, :index, :edit, :update, :destroy]
  # 管理者ユーザのみ使用可能
  before_action :admin_user, only: [:destroy, :edit, :update]

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
    @game = Game.find(params[:id])
    @posts = @game.posts.all
  end

  def destroy
    Game.find(params[:id]).destroy
    flash[:success] = "Game board deleted"
    redirect_to games_url
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      flash[:success] = "Game board updated"
      redirect_to @game
    else
      render 'edit'
    end
  end

  private

  def game_params
    params.require(:game).permit(:title, :description, :game_image)
  end

end
