require 'rails_helper'

RSpec.describe "Favoritegames", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/favoritegames/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/favoritegames/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
