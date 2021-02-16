class Favoritegame < ApplicationRecord
  belongs_to :user
  belongs_to :game

  # バリデーション
  # 同じ投稿を複数回お気に入り登録させないため。
  validates_uniqueness_of :game_id, scope: :user_id
end
