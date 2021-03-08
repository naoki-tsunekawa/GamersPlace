require 'rails_helper'

RSpec.describe "StaticPages", type: :system do

  # titleタグのテスト
  describe "check title tags" do
    it "the title contains home" do
      visit root_path
      expect(page).to have_title 'GamersPlays'
    end

    it "the title contains help" do
      visit help_path
      expect(page).to have_title 'Help | GamersPlays'
    end

    it "the title contains about" do
      visit about_path
      expect(page).to have_title 'About | GamersPlays'
    end

    it "the title contains contact" do
      visit contact_path
      expect(page).to have_title 'Contact | GamersPlays'
    end
  end

  # リンクテスト
  scenario "testing for layout links" do
    visit root_path
    aggregate_failures do
      expect(page).to have_link 'Gamers Plays', href: root_path
      expect(page).to have_link 'Home', href: root_path
      expect(page).to have_link 'Help', href: help_path
      expect(page).to have_link 'About', href: about_path
      expect(page).to have_link 'Contact', href: contact_path
      # expect(page).to have_link 'Sign up now!', href: signup_path
    end
  end

end
