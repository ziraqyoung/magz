require 'rails_helper'

RSpec.describe Group::Conversation, type: :model do
  let(:conversation) { build(:group_conversation, name: 'hi') }

  context "Validation" do
    it 'not valid without name' do
      conversation.name = ''
      expect(conversation).to_not be_valid
    end

    it 'not valid with duplicate name' do
      expect do
        create(:group_conversation, name: 'hi')
        create(:group_conversation, name: 'hi')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'Association' do
    it 'has_and_belongs_to_many users' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end

    it 'has_many messages' do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Group::Message')
      expect(association.options[:foreign_key]).to eq('conversation_id')
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  context "Callbacks" do
    it 'add conversation creator to the list of conversation users' do
      conversation.save
      expect(conversation.users).to include(conversation.creator)
    end
  end

  context 'Methods' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    describe '#add_user' do
      it 'add a user to a conversation' do
        conversation.save
        conversation.add_user(user1)
        expect(conversation.users).to include(user1, conversation.creator)
        conversation.add_user(user1)
        expect(conversation.users.count).to eq(2)
      end

      it 'doesnot add user to a conversation more than once' do
        conversation.save
        conversation.add_user(user1)
        expect do
          conversation.add_user(user1)
        end.to change(conversation.users, :count).by(0)
        expect do
          conversation.add_user(user2)
        end.to change(conversation.users, :count).by(1)
        expect do
          conversation.add_user(user2)
        end.to change(conversation.users, :count).by(0)
      end
    end
  end
end
