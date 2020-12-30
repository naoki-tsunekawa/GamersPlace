require 'rails_helper'

RSpec.describe "UsersEdits", type: :system do
  let(:user) { FactoryBot.create(:user) }
  scenario 'it fails edit with wrong information' do
    login_as(user)
    click_on 'Setting'
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
end
