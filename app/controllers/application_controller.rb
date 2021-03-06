class ApplicationController < ActionController::Base
	# Helper読み込み
	include SessionsHelper

	private

	# ログイン済みユーザーかどうか確認
	def logged_in_user
		# ログイン済みではなかった場合
		unless logged_in?
			# アクセスしようとしたURLを記憶
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	# 管理者かどうか確認
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
