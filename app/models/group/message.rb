class Group::Message < ApplicationRecord
  default_scope { includes(:user) }

  serialize :seen_by, Array
  serialize :added_new_users, Array

  belongs_to :conversation, class_name: 'Group::Conversation', foreign_key: 'conversation_id'
  belongs_to :user

  validates :content, :user_id, :conversation_id, presence: true

  def previous_message
    previous_message_index = (self.conversation.messages.index(self)) - 1
    self.conversation.messages[previous_message_index]
  end
end
