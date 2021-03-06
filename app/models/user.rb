class User < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :games, through: :posts
	has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :followers, through: :passive_relationships, source: :follower
	has_many :favoritegames, dependent: :destroy
	has_many :reviews, dependent: :destroy
	attr_accessor :remember_token
	before_save { self.email = email.downcase }

	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	# 渡された文字列のハッシュ値を返す
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# ランダムなトークンを返す
	def User.new_token
		SecureRandom.urlsafe_base64
	end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
	end

	# 渡されたトークンがダイジェストと一致したらtrueを返す
	def authenticated?(remember_token)
		# remember_digestがnilの時は比較処理しない
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# ユーザーのログイン情報を破棄する
	def forget
		update_attribute(:remember_digest, nil)
	end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

	# 既にお気に入りされているゲームかどうか調べる
	def already_favorited?(game)
		self.favoritegames.exists?(game_id: game.id)
	end

end
