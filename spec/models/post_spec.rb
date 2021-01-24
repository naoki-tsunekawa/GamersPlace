require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }

  it "is valid with post's test data" do
    expect(post).to be_valid
  end

  it "is invalid with no user_id" do
    post.user_id = nil
    expect(post).to be_invalid
  end

  it "is invalid with no content" do
    post.content = " "
    expect(post).to be_invalid
  end

  it "is invalid with 141-letter mails" do
    post.content = "a" * 141
    expect(post).to be_invalid
  end
end
