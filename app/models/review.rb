class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :score, presence: true

  # ユーザー個人のレビューのメソッド定義
  def user_review_score_percentage
		unless self.score.nil?
			score.round(1).to_f*100/5
		else
			0.0
		end
	end
end
