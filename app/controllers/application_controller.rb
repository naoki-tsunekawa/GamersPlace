class ApplicationController < ActionController::Base
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
end
