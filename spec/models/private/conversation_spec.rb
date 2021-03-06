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

  context "methods" do
    it "returns the opposed user of a conversation" do
      user1 = create(:user)
      user2 = create(:user)

      conversation = create(:private_conversation, recipient: user1, sender: user2)
      opposed_user = conversation.opposed_user(user1)
      expect(opposed_user).to eq user2

      # Ensure works in both direction
      opposed_user = conversation.opposed_user(user2)
      expect(opposed_user).to eq user1
    end
  end
end
