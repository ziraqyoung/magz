require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "new", type: :request do
  context 'non-signed in users' do
    it 'it redirects to root path' do
      get '/posts/new'
      expect(response).to redirect_to(login_path)
    end
  end

  context 'signed in users' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it 'renders a new template' do
      get '/posts/new'
      expect(response).to render_template(:new)
    end
  end
end
