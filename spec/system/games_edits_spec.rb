require 'rails_helper'

RSpec.describe "GamesEdits", type: :system do
  let(:game) { FactoryBot.create(:game) }
  let!(:admin_user) { FactoryBot.create(:user, email: 'admin_user@example.com', admin: true) }

  before do
    # ログイン処理
    login_as(admin_user)
    create_game_board(game)
    visit game_path(Game.last)
    click_on 'edit'
  end

  scenario 'it fails new with wrong infomation' do
    fill_in 'Title', with: ' '
    fill_in 'Description', with: 'description  system spec'
    click_on 'Update Game'
    aggregate_failures do
      expect(current_path).to eq game_path(Game.last)
      expect(has_css?('.alert-danger')).to be_truthy
    end
  end

  scenario 'it fails new with wrong infomation' do
    fill_in 'Title', with: 'Foo Bar'
    fill_in 'Description', with: 'description edit'
    click_on 'Update Game'
    aggregate_failures do
      expect(current_path).to eq game_path(Game.last)
      expect(has_css?('.alert-success')).to be_truthy
    end
  end
end
