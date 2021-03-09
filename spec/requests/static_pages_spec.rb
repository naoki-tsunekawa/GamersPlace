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
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  # static_pages/helpへのリクエストテスト
  # describe "GET /help" do
  #   it "returns http success" do
  #     get help_path
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # static_pages/aboutへのリクエストテスト
  describe "GET /about" do
    it "returns http success" do
      get about_path
      expect(response).to have_http_status(:success)
    end
  end

  # static_pages/contactへのリクエストテスト
  describe "GET /contact" do
    it "returns http success" do
      get contact_path
      expect(response).to have_http_status(:success)
    end
  end
end
