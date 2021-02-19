class StaticPagesController < ApplicationController
  def home
    @user = User.find(current_user.id)

    # ログイン中のユーザのお気に入りgame_idカラムを取得
    myfavoritegame = Favoritegame.where(user_id: current_user.id).pluck(:game_id)
    # gameテーブルからお気に入り登録ずみのレコードを取得
    @favorite_list = Game.find(myfavoritegame)
  end

  def help
  end

  def about
  end

  def contact
  end
end
