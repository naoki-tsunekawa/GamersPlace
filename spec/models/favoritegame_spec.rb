require 'rails_helper'

RSpec.describe Favoritegame, type: :model do
  let(:favoritegame) { FactoryBot.create(:favoritegame) }
  let(:user) { FactoryBot.build(:user) }
  let(:game) { FactoryBot.build(:game) }

  it "is valid with favorite's test data" do
    expect(favoritegame).to be_valid
  end

  # バリデーションのテスト
  # game_id
  it "is invalid with no game_id" do
    favoritegame.game_id = nil
    expect(favoritegame).to be_invalid
  end

  # user_id
  it "is invalid with same user_id" do
    favoritegame.user_id = nil
    expect(favoritegame).to be_invalid
  end

  # 関連づけ削除テスト
  describe "dependent: :destroy" do
    # ゲームもしくはユーザが消された場合お気に入りデータも削除
    let(:delete_favoritegame) { FactoryBot.create(:favoritegame, user_id: user.id, game_id: game.id) }

    before do
      user.save
      game.save
      delete_favoritegame
    end

    it "game delete succeeds" do
      expect do
        game.destroy
      end.to change(Favoritegame, :count).by(-1)
    end

    it "user delete succeeds" do
      expect do
        user.destroy
      end.to change(Favoritegame, :count).by(-1)
    end
  end

end
