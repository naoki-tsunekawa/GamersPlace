require 'rails_helper'

RSpec.describe "UsersEdits", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    # ログイン処理
    login_as(user)
    click_on 'Setting'
  end

  scenario 'it fails edit with wrong information' do
    fill_in '名前', with: ' '
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード', with: 'foo'
    fill_in 'パスワード(確認)', with: 'bar'
    click_on 'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-danger')).to be_truthy
    end
  end

  scenario 'it succeeds edit with correct information' do
    fill_in '名前', with: 'Foo Bar'
    fill_in 'メールアドレス', with: 'foo@bar.com'
    fill_in 'パスワード', with: ''
    fill_in 'パスワード(確認)', with: ''
    click_on 'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-success')).to be_truthy
    end
  end
end
