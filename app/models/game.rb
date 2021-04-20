class Game < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :users, through: :posts
	has_many :favoritegames, dependent: :destroy
	has_many :reviews, dependent: :destroy

	mount_uploader :game_image, ImageUploader
	# バリデーション
	validates :title, presence: true, length: { maximum: 50 }
	validates :description, presence: true, length: { maximum: 300 }

	# レビューのメソッド定義
	def avg_score
		unless self.reviews.empty?
			reviews.average(:score).round(1).to_f
		else
			0.0
		end
	end

	def review_score_percentage
		unless self.reviews.empty?
			reviews.average(:score).round(1).to_f*100/5
		else
			0.0
		end
	end

	# 検索メソッド
	def self.search(search)
		if search
			Game.where(["title LIKE ?", "%#{search}%"])
		else
			Game.all
		end
	end

end
