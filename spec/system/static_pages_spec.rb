require 'rails_helper'

RSpec.describe "StaticPages", type: :system do

  describe "check title tags" do
    # titleタグのテスト
    it "the title contains home" do
      visit root_path
      expect(page).to have_title 'GamersPlace'
    end

    it "the title contains help" do
      visit help_path
      expect(page).to have_title 'Help | GamersPlace'
    end

    it "the title contains about" do
      visit about_path
      expect(page).to have_title 'About | GamersPlace'
    end

    it "the title contains contact" do
      visit contact_path
      expect(page).to have_title 'Contact | GamersPlace'
    end
  end

end
