class Private::Message < ApplicationRecord
  default_scope { order(created_at: :asc) }
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :messagable, polymorphic: true

  has_rich_text :message_body
  validates :message_body, presence: true

  after_create_commit do
    broadcast_append_later_to \
      [messagable, :messages],
      target: "#{dom_id(messagable)}_messages",
      partial: 'private/messages/turbo_message_response',
      locals: { private_message: self }
  end

  def previous_message
    previous_message_index = self.messagable.messages.index(self) - 1
    self.messagable.messages[previous_message_index]
  end
end
