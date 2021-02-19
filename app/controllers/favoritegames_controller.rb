class FavoritegamesController < ApplicationController
  # 対象のゲーム情報を取得
  before_action :set_game
  # ログイン中のユーザのみ許可する(ログインしていない場合はログイン画面へ遷移)
  before_action :logged_in_user

  # お気に入り登録
  def create
    if @game.user_id != current_user.id
      @favoritegame = Favoritegame.create(user_id: current_user.id, game_id: @game.id)
    end
  end

  # お気に入り削除
  def destroy
    @favoritegame = Favoritegame.find(user_id: current_user.id, game_id: @game.id)
    @favoritegame.destroy
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end
end
