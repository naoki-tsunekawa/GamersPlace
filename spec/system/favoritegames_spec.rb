require 'rails_helper'

RSpec.describe "Favoritegames", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:game) { FactoryBot.create(:game) }

  before do
    login_as(user)
    game
    visit games_path
  end

  # ゲーム一覧画面お気に入り登録・解除テスト
  scenario "favorite game registration" do
    click_on "お気に入り登録"
    aggregate_failures do
      expect(has_css?(".fas")).to be_truthy
    end
    click_on "お気に入り解除"
    aggregate_failures do
      expect(has_css?(".far")).to be_truthy
    end
  end

end
