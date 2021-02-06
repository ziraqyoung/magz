class Private::Message < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :conversation, class_name: 'Private::Conversation', foreign_key: :conversation_id
end
