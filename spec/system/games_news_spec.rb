require 'rails_helper'

RSpec.describe "GamesNews", type: :system do
  let!(:admin_user) { FactoryBot.create(:user, email: 'admin_user@example.com', admin: true) }

  before do
    # ログイン処理
    login_as(admin_user)
    visit games_path
    click_on 'New Game Board!'
  end

  scenario 'it fails new with wrong infomation' do
    fill_in 'Title', with: ' '
    fill_in 'Description', with: 'description system spec'
    click_on 'Create Game'
    aggregate_failures do
      expect(current_path).to eq games_path
      expect(has_css?('.alert-danger')).to be_truthy
    end
  end

  scenario 'it succeeds new with correct information' do
    fill_in 'Title', with: 'Foo Bar'
    fill_in 'Description', with: 'description'
    click_on 'Create Game'
    aggregate_failures do
        expect(current_path).to eq game_path(Game.last)
        expect(has_css?('.alert-success')).to be_truthy
    end
  end
end
