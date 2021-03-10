class Group::Message < ApplicationRecord
  default_scope { includes(:user) }
  include ActionView::RecordIdentifier

  serialize :seen_by, Array
  serialize :added_new_users, Array

  belongs_to :conversation, class_name: 'Group::Conversation', foreign_key: 'conversation_id'
  belongs_to :user

  validates :message_body, :user_id, :conversation_id, presence: true

  after_create_commit do
    broadcast_append_later_to \
      [conversation, :messages],
      target: "#{dom_id(conversation)}_messages",
      partial: 'shared/messages/message',
      locals: { message: self }
  end

  def previous_message
    previous_message_index = (self.conversation.messages.index(self)) - 1
    self.conversation.messages[previous_message_index]
  end
end
