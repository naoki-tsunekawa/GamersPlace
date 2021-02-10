require 'rails_helper'

# following/followerページテスト
RSpec.describe "Followings", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_users) { FactoryBot.create_list(:user, 20) }

  before do
    other_users[0..9].each do |other_user|
      user.active_relationships.create!(followed_id: other_user.id)
      user.passive_relationships.create!(follower_id: other_user.id)
    end
    login_as(user)
  end

  scenario "The number of following and followers is correct" do
    # フォローの確認
    click_on "following"
    expect(user.following.count).to eq 10
    user.following.each do |user_following|
      expect(page).to have_link user_following.name, href: user_path(user_following)
    end

    # フォロワーの確認
    click_on "followers"
    expect(user.followers.count).to eq 10
    user.followers.each do |user_follower|
      expect(page).to have_link user_follower.name, href: user_path(user_follower)
    end
  end

  # unfollowの動作確認
  scenario "When user clicks on Unfollow, the number of following increases by -1" do
    visit user_path(other_users.first.id)
    expect do
      click_on "Unfollow"
      expect(page).not_to have_link "Unfollow"
      # Ajaxの処理待ち
      visit current_path
    end.to change(user.following, :count).by(-1)
  end

  # follow動作確認
  scenario "When user clicks on Follow, the number of following increases by 1" do
    visit user_path(other_users.last.id)
    expect do
      click_on "Follow"
      expect(page).not_to have_link "Follow"
      # Ajaxの処理待ち
      visit current_path
    end.to change(user.following, :count).by(1)
  end
end
