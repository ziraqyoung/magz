require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "Group::Conversations", type: :request do
  let(:creator) { create(:user) }
  let(:name) { "Hotwire and Rails" }
  let(:conversation) {create(:group_conversation, name: name)}

  context 'non-signed-in user' do
    it 'GET :index redirects to login path' do
      get group_conversations_url
      expect(response).to require_login
    end

    it 'GET :show redirects to login path' do
      get '/group/conversations/1'
      expect(response).to require_login
    end

    it 'POST :create redirects to login path' do
      post group_conversations_url, params: {name: name}
      expect(response).to require_login
    end
  end

  context 'signed-in user' do
    before(:each) { login_as(creator) }

    it 'render #new template to create a group conversation successfully' do
      get new_group_conversation_path
      expect(response).to render_template(:new)
      expect do 
        post '/group/conversations', params: { group_conversation: {name: name} }
      end.to change(Group::Conversation, :count).by(1)
      expect(response).to redirect_to(assigns(:group_conversation))
      follow_redirect!
      expect(response.body).to include(name)
    end

    it '#create doesnot save a conversation if name in empty' do
      get new_group_conversation_path
      expect(response).to render_template(:new)
      expect do 
        post '/group/conversations', params: { group_conversation: {name: ''} }
      end.to change(Group::Conversation, :count).by(0)
      within "#new_group_conversation" do
        expect(response.body).to have_content("Name can't be blank")
      end
    end

    it '#create doesnot save a conversation if name is already taken' do
      conversation
      get new_group_conversation_path
      expect(response).to render_template(:new)
      expect do 
        post '/group/conversations', params: { group_conversation: {name: name} }
      end.to change(Group::Conversation, :count).by(0)
      within "#new_group_conversation" do
        expect(response.body).to have_content('Name has already taken')
      end
    end
  end
end
