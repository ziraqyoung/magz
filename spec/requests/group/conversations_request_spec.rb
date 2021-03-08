require 'rails_helper'

RSpec.describe "Group::Conversations", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/group/conversations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/group/conversations/show"
      expect(response).to have_http_status(:success)
    end
  end

end
