require 'rails_helper'

RSpec.describe "StaticPages", type: :system do

  describe "check title tags" do
    # titleタグのテスト
    it "the title contains home" do
      visit "/static_pages/home"
      expect(page).to have_title 'GamersPlace'
    end

    it "the title contains help" do
      visit "/static_pages/help"
      expect(page).to have_title 'Help | GamersPlace'
    end

    it "the title contains about" do
      visit "/static_pages/about"
      expect(page).to have_title 'About | GamersPlace'
    end

    it "the title contains contact" do
      visit "/static_pages/contact"
      expect(page).to have_title 'Contact | GamersPlace'
    end
  end

end