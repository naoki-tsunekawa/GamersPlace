class Game < ApplicationRecord
	mount_uploader :game_image, ImageUploader
	# バリデーション
	validates :title, presence: true, length: { maximum: 50 }
	validates :description, presence: true, length: { maximum: 300 }
end
