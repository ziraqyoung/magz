require 'rails_helper'

RSpec.describe Private::MessagesHelper, type: :helper do
  context "#private_message_date_check" do
    let(:message) { create(:private_message) }
    let(:previous_message) { create(:private_message) }

    it "returns a new_date's partial path" do
      message.update(created_at: 2.days.ago)
      expect(helper.private_message_date_check message, previous_message).to eq('private/messages/message/new_date')
    end

    it "returns empty partial's path if messages on the same date" do
      expect(helper.private_message_date_check message, previous_message).to eq('shared/empty_partial')
    end

    it "returns empty partial's path if previous_message is undefined | empty" do
      expect(helper.private_message_date_check message, previous_message).to eq('shared/empty_partial')
    end
  end
end
