require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "Notifications", type: :request do
  let(:james) { create(:user) }
  let(:notification) { build(:notification) }

  context 'non-signed-in user' do
    it 'GET :index redirects to login path' do
      get notifications_url
      expect(response).to require_login
    end
  end

  context 'signed-in users' do
    before(:each) { login_as(james) }

    describe '#index' do
      it 'gets notifications for the current user' do
        get notifications_path
        expect(response).to render_template(:index)
      end
    end
  end
end
