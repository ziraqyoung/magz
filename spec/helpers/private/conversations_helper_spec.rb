require 'rails_helper'

RSpec.describe Private::ConversationsHelper, type: :helper do
  let(:recipient) { create(:user) }
  let(:current_user) { create(:user) }

  context '#get_contact_record' do
    it 'returns a Contact record' do
      contact = create(:contact, user_id: current_user.id, contact_id: recipient.id)
      allow(helper).to receive(:current_user).and_return(current_user)
      expect(helper.get_contact_record(recipient)).to eq(contact)
    end
  end

  context '#add_to_contacts_partial_path' do
    let(:contact) { create(:contact) }

    it 'returns empty_partial path' do
      allow(helper).to receive(:recipient_is_contact?).and_return(true)  
      expect(helper.add_to_contacts_partial_path(contact)).to eq('private/conversations/show/heading/already_in_contacts')
    end

    it "returns an add_user_to_contacts partial's path" do
      allow(helper).to receive(:recipient_is_contact?).and_return(false)
      allow(helper).to receive(:unaccepted_contact_exists).and_return(false)
      expect(helper.add_to_contacts_partial_path(contact)).to eq('private/conversations/show/heading/add_user_to_contacts')
    end

    it "returns pending_contact_request partial's path" do
      allow(helper).to receive(:recipient_is_contact?).and_return(false)
      allow(helper).to receive(:unaccepted_contact_exists).and_return(true)
      allow(helper).to receive(:current_user).and_return(current_user)
      allow(helper).to receive(:request_sent_by_user).and_return(true)
      expect(helper.add_to_contacts_partial_path(contact)).to eq('private/conversations/show/heading/pending_contact_request')
    end

    it "returns accept_contact_request partial's path" do
      allow(helper).to receive(:recipient_is_contact?).and_return(false)
      allow(helper).to receive(:unaccepted_contact_exists).and_return(true)
      allow(helper).to receive(:current_user).and_return(current_user)
      allow(helper).to receive(:request_sent_by_user).and_return(false)
      expect(helper.add_to_contacts_partial_path(contact)).to eq('private/conversations/show/heading/accept_contact_request')
    end
  end

  context "Private scope" do

    context "#unaccepted_contact_exists" do
      it 'returns false when contact is accepted' do
        contact = create(:contact, accepted: true)
        expect(helper.instance_eval { unaccepted_contact_exists(contact) }).to eq(false)
      end

      it 'returns false when contact not present' do
        contact = nil
        expect(helper.instance_eval { unaccepted_contact_exists(contact) }).to eq(false)
      end

      it 'returns true when contact not accepted' do
        contact = create(:contact, accepted: false)
        expect(helper.instance_eval { unaccepted_contact_exists(contact) }).to eq(true)
      end
    end

    context "#recipient_is_contact?" do
      it 'returns false when a recipient is not a contact' do
        allow(helper).to receive(:current_user).and_return(current_user)
        assign(:recipient, recipient)
        create_list(:contact, 2, user_id: current_user.id, accepted: true)
        expect(helper.instance_eval { recipient_is_contact? }).to eq(false)
      end

      it 'returns true when a recipient is a contact' do
        allow(helper).to receive(:current_user).and_return(current_user)
        assign(:recipient, recipient)
        create_list(:contact, 2, user_id: current_user.id, accepted: true)
        create(:contact, user_id: current_user.id, contact_id: recipient.id, accepted: true)
        expect(helper.instance_eval { recipient_is_contact? }).to eq(true)
      end
    end

    context "#request_sent_by_user" do
      it 'returns true' do
        allow(helper).to receive(:current_user).and_return(current_user)
        assign(:recipient, recipient)
        contact = create(:contact, user_id: current_user.id, accepted: false)
        expect(helper.instance_eval { request_sent_by_user(contact) }).to eq(true)
      end

      it 'returns false' do
        allow(helper).to receive(:current_user).and_return(current_user)
        assign(:recipient, recipient)
        contact = create(:contact, contact_id: recipient.id, accepted: false)
        expect(helper.instance_eval { request_sent_by_user(contact) }).to eq(false)
      end
    end
  end
end
