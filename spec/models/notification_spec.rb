require 'rails_helper'

RSpec.describe Notification, type: :model do
  context 'Validations' do
    let(:notification) { build(:notification) }

    it 'is valid' do
      expect(notification).to be_valid
    end

    it 'not valid without actor' do
      notification.actor = nil
      expect(notification).to_not be_valid
    end

    it 'not valid without a recipient' do
      notification.recipient = nil
      expect(notification).to_not be_valid
    end

    it 'not valid without a notifiable' do
      notification.notifiable = nil
      expect(notification).to_not be_valid
    end
  end

  context 'Associations' do
    it 'belongs_to a recipient' do
      association = described_class.reflect_on_association(:recipient)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
    end

    it 'belongs_to an actor' do
      association = described_class.reflect_on_association(:actor)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
    end

    it 'belongs_to an notifiable as polymorphic' do
      association = described_class.reflect_on_association(:notifiable)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:polymorphic]).to eq(true)
    end
  end

  context 'Scopes'do
    describe '#unread' do
      it 'returns unread notificatins only' do
        create(:notification)
        expect(Notification.count).to eq 1
        expect(Notification.unread.count).to eq 1

        create_list(:notification, 2, read_at: DateTime.now - 1.hour)
        expect(Notification.count).to eq 3
        expect(Notification.unread.count).to eq 1
      end
    end
  end
end
