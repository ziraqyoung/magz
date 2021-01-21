require 'rails_helper'

RSpec.feature "Visit single post", type: :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  scenario "User navigates to a single post from the home page" do
    post
    visit root_path
    page.find(".single_post_card a").click
    expect(page).to have_content(post.content)
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.user.name)
  end
end
