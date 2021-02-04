require 'rails_helper'

RSpec.feature "Create a new post", type: :feature do
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  shared_examples "user creates a new post" do |branch|
    scenario "successfull create for #{branch} branch" do
      create(:category, name: 'category', branch: branch)
      visit send("#{branch}_posts_path")
      find('.new_post a').click
      fill_in 'post[title]', with: 'a' * 20
      fill_in 'post[content]', with: 'a' * 20
      select 'category', from: 'post[category_id]'
      click_on 'Create a post'
      expect(page).to have_selector('h2', text: 'a' * 20)
    end
  end

  include_examples 'user creates a new post', 'hobby'
  include_examples 'user creates a new post', 'study'
  include_examples 'user creates a new post', 'team'
end
