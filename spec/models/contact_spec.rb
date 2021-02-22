require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { build(:contact) }

  context "Associations" do
    it 'belongs_to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs_to a contact' do
      association = described_class.reflect_on_association(:contact)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
    end
  end

  context "Validations" do
    it 'is valid' do
      expect(contact).to be_valid
    end

    it 'is not valid with the same user' do
      contact = create(:contact)
      duplicate_contact = contact.dup
      expect(duplicate_contact).to_not be_valid
    end
  end

  context "Methods" do
    describe '#find_by_users' do
      it 'find by users' do
        user1 = create(:user)
        user2 = create(:user)
        contact = create(:contact, user: user1, contact: user2)
        expect(Contact.find_by_users(user1.id, user2.id)).to eq(contact)
      end
    end
  end
end
