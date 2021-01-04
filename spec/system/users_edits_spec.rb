require 'rails_helper'

RSpec.describe "UsersEdits", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    # ログイン処理
    login_as(user)
    click_on 'Setting'
  end

  scenario 'it fails edit with wrong information' do
    fill_in 'Name', with: ' '
    fill_in 'Email', with: 'user@invalid'
    fill_in 'Password', with: 'foo'
    fill_in 'Confirmation', with: 'bar'
    click_on 'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-danger')).to be_truthy
    end
  end

  scenario 'it succeeds edit with correct information' do
    fill_in 'Name', with: 'Foo Bar'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: ''
    fill_in 'Confirmation', with: ''
    click_on 'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-success')).to be_truthy
    end
  end
end
