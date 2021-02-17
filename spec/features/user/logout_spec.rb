require 'rails_helper'

RSpec.feature 'Logout', type: :feature do
  let(:user) { create(:user) }

  scenario "User successfully logs out", js: true do
    sign_in user
    visit root_path
    find("details#me_menu").click
    find("#me_menu a", text: 'Log out').click
    within "#top-nav" do
      expect(page).to have_selector("a", text: 'Login')
      expect(page).to have_selector("a", text: 'Signup')
    end
  end
end
