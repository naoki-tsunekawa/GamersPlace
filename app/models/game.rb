class Game < ApplicationRecord
	mount_uploader :game_image, ImageUploader
	# バリデーション
	validates :title, presence: true
end
