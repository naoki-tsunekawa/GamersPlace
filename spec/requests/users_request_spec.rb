require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, email: 'other_user@example.com') }

  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  # 有効なユーザの登録テスト
  describe "POST /users" do
    let(:user) { FactoryBot.attributes_for(:user) }
    it "adds new user with correct signup information" do
      aggregate_failures do
        expect do
          post users_path, params: { user: user }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_path(User.last)
        expect(is_logged_in?).to be_truthy
      end
    end
  end

  # ユーザ編集のテスト
  describe "PATCH /users/:id" do
    # ログイン状態の判別のためのテスト
    before do
      log_in_as(user)
    end

    it 'succeeds edit with correct information' do
      patch user_path(user), params: { user: {
        name: "Foo Bar",
        email: "foo@bar.com",
        password: "",
        password_confirmation: "",
      } }
      expect(response).to redirect_to user_path(user)
    end

    it 'fails edit with wrong information' do
      patch user_path(user), params: { user: {
        name: " ",
        email: "foo@invalid",
        password: "foo",
        password_confirmation: "bar",
      } }
      expect(response).to have_http_status(200)
    end
  end

  # 正しいユーザのみ編集できるかのテスト
  describe "before_action: :correct_user" do

    before do
      log_in_as(other_user)
    end

    it 'redirects edit when logged in as wrong user' do
      get edit_user_path(user)
      expect(response).to redirect_to root_path
    end

    it 'redirects update when logged in as wrong user' do
      patch user_path(user), params: { user: {
        name: user.name,
        email: "update_user@example.com",
      } }
      expect(response).to redirect_to root_path
    end
  end
end
