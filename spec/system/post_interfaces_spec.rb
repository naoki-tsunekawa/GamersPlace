require 'rails_helper'

RSpec.describe "PostInterfaces", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
  end

  # 無効な送信


  # 有効な送信


  # 投稿を削除する



  # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)


  pending "add some scenarios (or delete) #{__FILE__}"
end
