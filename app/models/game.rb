class Game < ApplicationRecord
	# バリデーション
	validates :title, presence: true
end
