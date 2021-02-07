require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, email: 'other_user@example.com') }
  let!(:admin_user) { FactoryBot.create(:user, email: 'admin_user@example.com', admin: true) }

  describe 'GET /new' do
    it 'returns http success' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  # 有効なユーザの登録テスト
  describe 'POST /users' do
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

  # ユーザ一覧のテスト
  describe 'GET /users' do
    it 'redirects login when not logged in' do
      get users_path
      expect(response).to redirect_to login_url
    end
  end

  # ユーザ編集のテスト
  describe 'PATCH /users/:id' do
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
  describe 'before_action: :correct_user' do

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

  # フレンドリーフォワーディングのテスト
  describe 'friendly forwarding' do
    it 'succeeds' do
      # ログインしていない状態で編集画面へアクセスする
      get edit_user_path(user)
      # ログインすると編集画面へ遷移
      log_in_as(user)
      expect(response).to redirect_to edit_user_url(user)
    end
  end

  # ユーザ削除のテスト
  describe "delete /users/:id" do

    it 'fails when not admin' do
      log_in_as(user)
      aggregate_failures do
        expect do
          delete user_path(admin_user)
        end.to change(User, :count).by(0)
        expect(response).to redirect_to root_url
      end
    end

    it 'succeds when user is administrator' do
      log_in_as(admin_user)
      # 削除用のユーザを作成
      user
      aggregate_failures do
        expect do
          delete user_path(user)
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to users_url
      end
    end
  end

  #ログイン状態のテスト
  describe "before_action: :logged_in_user" do
    it 'redirects following when not logged in' do
      get following_user_path(user)
      expect(response).to redirect_to login_url
    end

    it 'redirects followers when not logged in' do
      get followers_user_path(user)
      expect(response).to redirect_to login_url
    end
  end

end
