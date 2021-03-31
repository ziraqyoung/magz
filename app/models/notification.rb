class Notification < ApplicationRecord
  belongs_to :actor, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true
  
  scope :latest, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }

  validates :actor, :recipient, presence: true

  # TODO: This just dont work
  # replace with a partial
  after_create_commit do
    broadcast_replace_later_to \
      "notifications.#{self.recipient.id}",
      target: "notifications-count",
      partial: 'notifications/notification_count',
      locals: { notification_count: Notification.new_for_user(self.recipient.id).count }
  end

  def self.new_for_user(recipient_id)
    where(recipient_id: recipient_id).unread
  end
end
