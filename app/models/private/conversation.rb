class Private::Conversation < ApplicationRecord
  has_many :messages, class_name: 'Private::Message', foreign_key: :conversation_id
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
end
