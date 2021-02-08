require 'rails_helper'

RSpec.feature "Visit single post", type: :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category, branch: 'hobby') }
  let(:post) { create(:post, category: category) }

  scenario "User navigates to a single post from the home page" do
    post
    visit root_path
    page.find(".single_post_card a").click
    expect(page).to have_content(post.content)
    expect(page).to have_content(post.title)
  end
end
