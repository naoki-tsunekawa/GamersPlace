class Post < ApplicationRecord
  belongs_to :user
  belongs_to :game
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
end
