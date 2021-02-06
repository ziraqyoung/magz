require 'rails_helper'

RSpec.describe Private::Message, type: :model do
  context "Validation" do
    let(:message) { build(:private_message) }

    it 'is valid' do
      expect(message).to be_valid 
    end

    it 'not valid without message body' do
      message.body = ''
      expect(message).to_not be_valid 
    end

    it 'not valid without sender' do
      message.user = nil
      expect(message).to_not be_valid 
    end

    it 'not valid without conversation_id body' do
      message.conversation = nil
      expect(message).to_not be_valid 
    end
  end
end
