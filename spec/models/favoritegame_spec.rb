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


end
