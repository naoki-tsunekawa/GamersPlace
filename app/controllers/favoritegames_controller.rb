class FavoritegamesController < ApplicationController
  # ログイン中のユーザのみ許可する(ログインしていない場合はログイン画面へ遷移)
  before_action :logged_in_user

  # お気に入り登録
  def create
    @favoritegame = current_user.favoritegames.create(game_id: params[:game_id])
    redirect_back(fallback_location: root_path)
  end

  # お気に入り削除
  def destroy
    @game = Game.find(params[:game_id])
    @favoritegame = current_user.favoritegames.find_by(game_id: @game.id)
    @favoritegame.destroy
    redirect_back(fallback_location: root_path)
  end

end
