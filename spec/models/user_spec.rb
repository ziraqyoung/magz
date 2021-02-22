require 'rails_helper'

RSpec.describe User, type: :model do
  context "Association" do
    it 'has_many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has_many contacts' do
      association = described_class.reflect_on_association(:contacts)
      expect(association.macro).to eq(:has_many)
    end

    it 'has_many all_received_contact_requests' do
      association = described_class.reflect_on_association(:all_received_contact_requests)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq("Contact")
      expect(association.options[:foreign_key]).to eq("contact_id")
    end

    it 'has_many accepted_sent_contact_requests' do
      association = described_class.reflect_on_association(:accepted_sent_contact_requests)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:contacts)
      expect(association.options[:source]).to eq(:contact)
    end

    it 'has_many accepted_received_contact_requests' do
      association = described_class.reflect_on_association(:accepted_received_contact_requests)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:all_received_contact_requests)
      expect(association.options[:source]).to eq(:user)
    end

    it 'has_many pending_sent_contact_requests' do
      association = described_class.reflect_on_association(:pending_sent_contact_requests)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:contacts)
      expect(association.options[:source]).to eq(:contact)
    end

    it 'has_many pending_received_contact_requests' do
      association = described_class.reflect_on_association(:pending_received_contact_requests)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:all_received_contact_requests)
      expect(association.options[:source]).to eq(:user)
    end
  end
  context "Methods" do
    let(:user) { build(:user) }
    let(:contact_requests) do
      @user = create(:user)
      # dummy contacts
      create_list(:contact, 2)
      create_list(:contact, 2, accepted: true)

      # contacts sent by user
      create(:contact, user_id: @user.id)
      create(:contact, user_id: @user.id, accepted: true)

      # contacts received by user
      create(:contact, contact_id: @user.id)
      create(:contact, contact_id: @user.id, accepted: true)
    end

    before :each do
      contact_requests
    end

    describe "#accepted_sent_contact_requests" do
      it 'gets only accepted contact requests' do
        expect(@user.accepted_sent_contact_requests.count).to eq(1)
      end
    end

    describe "#accepted_received_contact_requests" do
      it 'gets only accepted contact requests' do
        expect(@user.accepted_received_contact_requests.count).to eq(1)
      end
    end

    describe "#pending_sent_contact_requests" do
      it 'gets only unaccepted contact requests' do
        expect(@user.pending_sent_contact_requests.count).to eq(1)
      end
    end

    describe "#pending_received_contact_requests" do
      it 'gets only unaccepted contact requests' do
        expect(@user.pending_received_contact_requests.count).to eq(1)
      end
    end
  end
end
