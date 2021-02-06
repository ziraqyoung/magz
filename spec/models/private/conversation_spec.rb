require 'rails_helper'

RSpec.describe Private::Conversation, type: :model do
  context "Scope" do
    it 'gets a conversation between two users' do
      user1 = create(:user)
      user2 = create(:user)
      create(:private_conversation, sender: user1, recipient: user2)
      conversation = Private::Conversation.between_users(user1, user2)
      expect(conversation.count).to eq(1)
    end
  end
end
