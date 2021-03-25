class Notification < ApplicationRecord
  belongs_to :actor, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true
  
  scope :latest, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }

  validates :actor, :recipient, presence: true
  # Notes
  # send current notification to the job
  # with an after create callback
  # after_create { NotificationBroadcastJob.perform_later(self) }

  def self.for_user(recipient_id)
    where(recipient_id: recipient_id)
  end
end
