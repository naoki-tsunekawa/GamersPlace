class Post < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
