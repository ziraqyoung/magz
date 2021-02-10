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

  context "#sent_or_received" do
    let(:user) { create(:user) }
    let(:message) { create(:private_message) }

    it "returns `float-right`" do
      message.update(user_id: user.id)
      expect(helper.sent_or_received message, user).to eq('float-right')
    end

    it "returns `float-left flex-row-reverse`" do
      expect(helper.sent_or_received message, user).to  eq('float-left flex-row-reverse')
    end
  end
end
