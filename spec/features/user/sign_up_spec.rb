require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  let(:user) { build(:user) }

  scenario "user navigates to the sign up page and signs up successfully" do
    visit root_path
    within "#top-nav" do
      find("a", text: 'Signup').click
    end
    fill_in "user[name]", with: user.name
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password_confirmation
    click_button "Sign up"
    expect(page).to have_selector("#me_menu")
  end
end
