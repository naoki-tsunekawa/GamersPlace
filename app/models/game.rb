class Game < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :users, through: :posts
	has_many :favoritegames, dependent: :destroy
	has_many :reviews, dependent: :destroy

	mount_uploader :game_image, ImageUploader
	# バリデーション
	validates :title, presence: true, length: { maximum: 50 }
	validates :description, presence: true, length: { maximum: 300 }
end
