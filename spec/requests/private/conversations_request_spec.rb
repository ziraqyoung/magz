require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "Private::Conversations", type: :request do
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:new_post) { create(:post, user: recipient) }
  let(:conversation) { build(:private_conversation, sender: sender, recipient: recipient ) }
  let(:conversation_attrs) { attributes_for(:private_conversation) }

  context 'non-signed-in user' do
    it 'GET :index redirects to login path' do
      get private_conversations_url
      expect(response).to require_login
    end

    it 'GET :show redirects to login path' do
      get '/private/conversations/1'
      expect(response).to require_login
    end

    it 'POST :create redirects to login path' do
      get private_conversations_url
      expect(response).to require_login
    end
  end

  context 'signed-in user' do
    before(:each) { login_as(sender) }

    it 'render show template to create a conversation' do
      get post_path(new_post)
      expect(response).to render_template(:show)
      post '/private/conversations', params: { post_id: new_post.id, message_body: 'Hi' }

      expect(response).to redirect_to(assigns(:conversation))
      follow_redirect!
      expect(response.body).to include(recipient.name)
      expect(response.body).to include('Hi')
    end
  end
end
