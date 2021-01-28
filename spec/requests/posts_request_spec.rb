require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "posts#create" do
		let(:post_data) { FactoryBot.attributes_for(:post) }
		let(:post_request) { post posts_path, params: { post: post_data } }


    context "when not logged in" do
			it "doesn't change post's count" do
				expect { post_request }.to change(Post, :count).by(0)
				end
      end

      it "redirects to login_url" do
        expect(post_request).to redirect_to login_url
      end
    end

	describe "posts#destroy" do
    let!(:post_data) { FactoryBot.create(:post) }
    let(:delete_request) { delete post_path(post_data) }

    context "when not logged in" do
      it "doesn't change post's count" do
        expect { delete_request }.to change(Post, :count).by(0)
      end

      it "redirects to login_url" do
        expect(delete_request).to redirect_to login_url
      end
    end
  end
end
