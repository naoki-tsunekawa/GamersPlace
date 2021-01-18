module ApplicationHelper
	# ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "GamersPlace"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # 管理者ユーザかどうか確認
  def admin_logged_in?
		current_user.admin?
	end
end
