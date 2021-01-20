require 'rails_helper'

RSpec.describe "Games", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:user, email: 'admin_user@example.com', admin: true) }
  let(:game) { FactoryBot.create(:game) }

  # 有効なユーザでのゲーム掲示板作成テスト
  describe 'GET /new' do
    it 'redirects login when not logged in' do
      get new_game_path
      expect(response).to redirect_to login_url
    end

    it 'success access new when logged in' do
      get new_game_path
      log_in_as(user)
      expect(response).to redirect_to new_game_path
    end
  end

  # 有効なユーザで掲示板作成テスト
  describe 'POST /games' do
    let(:new_game) { FactoryBot.attributes_for(:game) }

    it 'Add the correct game board as an admin' do
      log_in_as(admin_user)
      aggregate_failures do
        expect do
          post games_path, params: { game: {
            title: "new title",
            description: "new description",
            game_image: "",
          }}
        end.to change(Game, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to game_path(Game.last)
      end
    end
  end

  # 掲示板一覧のテスト
  describe 'GET /games' do
    # ログインしていない状態で掲示板一覧にアクセスできない
    it 'redirects login when not logged in' do
      get games_path
      expect(response).to redirect_to login_url
    end

    it 'success access index when logged in' do
      get games_path
      log_in_as(user)
      expect(response).to redirect_to games_path
    end
  end

  # 掲示板編集のテスト
  describe 'PATCH /games/:id' do
    before do
      log_in_as(admin_user)
      game
    end

    # 掲示板の編集成功テスト
    it 'succeeds edit with correct information' do
      patch game_path(game), params: { game: {
        title: "Edit Example Game",
        discription: "Edit Example description",
        game_image: "",
      } }
      expect(response).to redirect_to game_path(game)
    end

    # 掲示板の編集失敗テスト
    it 'fails edit with wrong information' do
      patch game_path(game), params: { game: {
        title: "",
        discription: "Edit Example description",
        game_image: "",
      } }
      expect(response).to have_http_status(:success)
    end
  end

  # 掲示板削除のテスト
  describe 'delete /games/:id' do
    it 'fails when not admin' do
      log_in_as(user)
      game
      aggregate_failures do
        expect do
          delete game_path(game)
        end.to change(Game, :count).by(0)
        expect(response).to redirect_to root_url
      end
    end

  end

end
