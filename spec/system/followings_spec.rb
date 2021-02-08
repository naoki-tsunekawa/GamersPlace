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
end
