require 'rails_helper'

RSpec.describe "PostInterfaces", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:game) { FactoryBot.create(:game) }

  before do
    game
    login_as(user)
    visit games_path
    click_on 'Example Game'
  end

  scenario "post interface" do
  # 無効な送信
  click_on "Post"
  expect(has_css?('.alert-danger')).to be_truthy
  # 有効な送信
  valid_content = "Test post contents"
  fill_in "post_content", with: valid_content
  expect do
    click_on "Post"
    expect(current_path).to eq game_path(Game.last)
    expect(has_css?('.alert-success')).to be_truthy
  end.to change(Post, :count).by(1)

  # # 投稿を削除する
  # accept_confirm do
  #   click_link "delete"
  # end
  # expect do
  #   expect(page.accept_confirm).to eq "You sure?"
  #   expect(page).to have_content "post deleted"
  #   expect(current_path).to eq game_path(Game.last)
  #   expect(has_css?('.alert-success')).to be_truthy
  # end.to change(Post, :count).by(-1)

  # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)

  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
