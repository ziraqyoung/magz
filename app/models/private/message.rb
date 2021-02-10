class Private::Message < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :conversation, class_name: 'Private::Conversation', foreign_key: :conversation_id

  def previous_message
    previous_message_index = self.conversation.messages.index(self) - 1
    self.conversation.messages[previous_message_index]
  end
end
