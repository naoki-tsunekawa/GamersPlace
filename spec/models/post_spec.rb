require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }
  let(:user) { FactoryBot.build(:user) }
  let(:game) { FactoryBot.build(:game) }

  it "is valid with post's test data" do
    expect(post).to be_valid
  end

  # バリデーションのテスト
  it "is invalid with no user_id" do
    post.user_id = nil
    expect(post).to be_invalid
  end

  it "is invalid with no content" do
    post.content = " "
    expect(post).to be_invalid
  end

  it "is invalid with 300-letter mails" do
    post.content = "a" * 301
    expect(post).to be_invalid
  end

  # 投稿の順序づけテスト
  describe "Sort by latest" do
    let!(:day_before_yesterday) { FactoryBot.create(:post, :day_before_yesterday) }
    let!(:now) { FactoryBot.create(:post, :now) }
    let!(:yesterday) { FactoryBot.create(:post, :yesterday) }

    it "succeeds" do
      expect(Post.first).to eq now
    end
  end

  # 関連づけ削除テスト
  describe "dependent: :destroy" do
    let(:delete_post) { FactoryBot.create(:delete_post, user_id: user.id, game_id: game.id) }
    before do
      user.save
      game.save
      delete_post
    end

    it "user delete succeeds" do
      expect do
        user.destroy
      end.to change(Post, :count).by(-1)
    end

    it "game delete succeeds" do
      expect do
        game.destroy
      end.to change(Post, :count).by(-1)
    end
  end
end
