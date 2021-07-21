require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
  # signup失敗時のmessageテスト
  scenario 'Don\'t create new data when user submits invalid information' do
    visit signup_path
    fill_in '名前', with: ' '
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード', with: 'foo'
    fill_in 'パスワード(確認)', with: 'bar'
    click_on 'Create my account'
    aggregate_failures do
      expect(current_path).to eq users_path
      expect(page).to have_content 'Sign up'
      # expect(page).to have_content 'The form contains 4 errors'
    end
  end

  # signup成功時のflashテスト
  scenario 'Create new data when user submits valid information' do
    visit signup_path
    fill_in '名前', with: 'Example User'
    fill_in 'メールアドレス', with: 'user@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード(確認)', with: 'password'
    click_on 'Create my account'
    aggregate_failures do
      expect(current_path).to eq user_path(User.last)
      expect(has_css?('.alert-success')).to be_truthy
      visit current_path # 再読み込み
      expect(has_css?('.alert-success')).to be_falsy
    end
  end
end
