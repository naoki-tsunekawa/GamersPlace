require 'rails_helper'

RSpec.describe "PostsNews", type: :system do
	let(:user) { FactoryBot.create(:user) }
	let(:post_data) { FactoryBot.create(:post) }

  before do
    # ログイン処理
		login_as(user)
		post_data
    visit games_path
    click_on 'Example Game'
  end

  scenario 'Posting failure' do
    fill_in 'post_content', with: ' '
    click_on '投稿する'
    aggregate_failures do
      expect(current_path).to eq game_path(Game.last)
      expect(has_css?('.alert-danger')).to be_truthy
    end
  end

  scenario 'Posting success' do
    fill_in 'post_content', with: 'FooBar'
    click_on '投稿する'
    aggregate_failures do
        expect(current_path).to eq game_path(Game.last)
        expect(has_css?('.alert-success')).to be_truthy
    end
  end
end
