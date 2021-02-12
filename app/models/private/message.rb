class Private::Message < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :user
  belongs_to :messagable, polymorphic: true

  has_rich_text :message_body
  validates :message_body, presence: true

  def previous_message
    previous_message_index = self.conversation.messages.index(self) - 1
    self.conversation.messages[previous_message_index]
  end
end
