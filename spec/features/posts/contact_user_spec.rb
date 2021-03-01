require 'rails_helper'

RSpec.feature "Contact user", type: :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category, name: 'Arts', branch: 'hobby') }
  let(:post) { create(:post, category_id: category.id) }

  context "Logged in user" do
    before :each do
      sign_in user
    end

    scenario "successfull creates a conversation & sends a message to a post's author", js: true do
      visit(post_path post)
      expect(page).to have_selector(".contact-user form")
      within '.contact-user form' do
        find('trix-editor').click.set('a' * 20)
        click_on 'Send a message'
      end
      expect(page).to_not have_selector(".contact-user trix-editor")
      expect(page).to have_content('Go to Messages')
    end

    scenario "successfull create a conversation to a post's author, even when no message was sent", js: true do
      visit(post_path post)
      expect(page).to have_selector(".contact-user form")
      within '.contact-user form' do
        click_on 'Send a message'
      end
      expect(page).to_not have_selector(".contact-user trix-editor")
      expect(page).to have_content('Go to Messages')
    end

    scenario "see an already contacted user", js: true do
      create(:private_conversation_with_messages, recipient_id: post.user.id, sender_id: user.id)
      visit(post_path post)
      expect(page).to_not have_selector(".contact-user trix-editor")
      expect(page).to have_content('Go to Messages')
    end
  end

  context 'non-logged in user' do
    scenario 'sees a login required message to contact user' do
      visit(post_path post)
      expect(page).to have_selector('div', text: 'To contact user you have to Login')
    end
  end
end
