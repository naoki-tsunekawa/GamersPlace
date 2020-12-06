require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  # rootへのリクエストテスト
  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  # static_pages/homeへのリクエストテスト
  describe "GET /home" do
    it "returns http success" do
      get "/static_pages/home"
      expect(response).to have_http_status(:success)
    end
  end

  # static_pages/helpへのリクエストテスト
  describe "GET /help" do
    it "returns http success" do
      get "/static_pages/help"
      expect(response).to have_http_status(:success)
    end
  end

  # static_pages/aboutへのリクエストテスト
  describe "GET /about" do
    it "returns http success" do
      get "/static_pages/about"
      expect(response).to have_http_status(:success)
    end
  end
end
