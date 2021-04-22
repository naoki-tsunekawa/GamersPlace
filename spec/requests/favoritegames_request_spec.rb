require 'rails_helper'

RSpec.describe "Favoritegames", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:game) { FactoryBot.create(:game) }

  describe "Favoritegames#create" do
    let(:post_request) { post game_favoritegames_path(game.id) }

    context "when not logged in" do
      it "doesn't change favoritegame's count" do
        # ログインせずにお気に入り登録する
        # expect { post game_favoritegames_path(game.id) }.to change{ Favoritegame.count }.by(0)
        expect { post_request }.to change(Favoritegame, :count).by(0)
      end

      it "redirects to login_url" do
        expect(post_request).to redirect_to login_url
      end
    end

    context "when logged in" do
      it "change favoritegame's count" do
        # ログインした状態でお気に入り登録する
        log_in_as(user)
        expect { post_request }.to change(Favoritegame, :count).by(1)
      end
    end
  end


  describe "Favoritegames#destroy" do
    let!(:favoritegame_data) { FactoryBot.create(:favoritegame) }
    let(:delete_request) { delete game_favoritegames_path(favoritegame_data) }

    context "when not logged in" do
      it "doesn't change favoritegame's count" do
        expect{ delete_request }.to change(Favoritegame, :count).by(0)
      end

      it "redirects to login_url" do
        expect(delete_request).to redirect_to login_url
      end
    end
  end

end
