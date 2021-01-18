require 'rails_helper'

RSpec.feature "Login",type: :feature do
  let(:user) { create(:user) }

  scenario "user navigates to the login page and signs in successfully" do
    user
    visit root_path
    find('nav a', text: 'Login').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button "Sign in"
    expect(page).to have_content(user.name)
  end
end
