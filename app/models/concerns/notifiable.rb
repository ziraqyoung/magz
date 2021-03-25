# notifcation.rb model file
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
  #
  # after_create { NotificationBroadcastJob.perform_later(self) }

  after_create_commit do
    broadcast_append_later_to \
      ["notifications", self.recipient.id], # => notifications_1
      target: "#{dom_id(conversation)}_messages",
      partial: 'path/to/one/notification/partial',
      locals: { message: self, notification_count: Notification.for_user(notification.recipient).count }
  end

  def self.for_user(recipient)
    where(recipient: recipient)
  end
end


# notification_broadcast_job.rb
#
class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    notification_count = Notification.for_user(notification.user)

    ActionCable.server.broadcast "notification.#{notification.user_id}", action: "new_notification", message: notification_count
  end
end

# notifiable.rb model concern
# this module is includable in any model
# eg in Contact model
# if the model has user_ids, then the NotificationSenderJob runs
# passing self
module Notifiable
  extend ActiveSupport::Concern

  included do
    # this appends to each place this odule is included
    has_many :notifications, as: :notifiable
    after_commit :send_notification_to_users
  end

  def send_notification_to_users
    if self.respond_to? :user_ids
      NotificationSenderJob.perform_later(self)
    end
  end
end

# notification_sender_job.rb
class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(notifiable)
    notifiable.users_ids.each do |user_id|
      Notification.create(notifiable: notifiable, user_id: user_id)
    end
  end
end

# gem 'sinatra'
# gem 'sidekiq'
# bundle install
#
# in config/application.rb
# config.active_job.queue_adapter = :sidekiq

# post.rb
# usage of this module
class Post < ApplicationRecord
  include Notifiable

  belongs_to :user

  def user_ids
    # @post = Post.find 1
    # @post.user_ids
    User.all.ids # send notifications to all users (we shot ourself in the foot
  end
end

# notification_channel.rb
# create a channel that will transmit all the notifcations
class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification.#{current_user.id}"
  end

  def unsubscribe
    # any cleanup
  end
end

