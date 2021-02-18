require 'rails_helper'

RSpec.describe Private::Message, type: :model do
  context "Validation" do
    let(:message) { build(:private_message) }

    it 'is valid' do
      expect(message).to be_valid 
    end

    it 'not valid without message body' do
      message.message_body = ''
      expect(message).to_not be_valid 
    end

    it 'not valid without sender' do
      message.user = nil
      expect(message).to_not be_valid 
    end

    it 'not valid without messagable polymorphic' do
      message.messagable = nil
      expect(message).to_not be_valid 
    end
  end

  context "Method" do
    describe "#previous_message" do
      it "gets a previous message" do
        conversation = create(:private_conversation)
        message1 = create(:private_message, messagable: conversation)
        message2 = create(:private_message, messagable: conversation)
        expect(message2.previous_message).to eq(message1)
      end
    end
  end
end
