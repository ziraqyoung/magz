require 'rails_helper'

RSpec.feature "Login",type: :feature do
  let(:user) { create(:user) }

  scenario "user navigates to the login page and signs in successfully", js: true do
    user
    visit root_path
    within "#top-nav" do
      find('a', text: 'Login').click
    end
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button "Sign in"
    expect(page).to have_selector("#me_menu")
  end
end
