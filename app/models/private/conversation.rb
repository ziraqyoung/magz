class Private::Conversation < ApplicationRecord
  has_many :messages, as: :messagable, class_name: 'Private::Message', dependent: :destroy 

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  scope :between_users, ->(user1_id, user2_id) do
    where(sender_id: user1_id, recipient_id: user2_id).or(
      where(sender_id: user2_id, recipient_id: user1_id)
    )
  end

  def opposed_user(user)
    user == sender ? recipient : sender
  end
end
