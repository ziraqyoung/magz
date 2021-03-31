# 1. Mount ActinCable in config.routes.rb
Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
end

# 2. Setup actiocable connection within connection.rb
# app/channels/application_cable/connection.rb
#

# 3. save the user in a cookie via warden hooks
#

# notifcation.rb model file
# `
#   James sent you a contact request
#   Phill liked your post
# `
class Notification < ApplicationRecord
  # setups association
  belongs_to :actor, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true
  
  # defined scopes
  scope :latest, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }

  validates :actor, :recipient, presence: true

  # ensures that sending notification or rather broadcasting is actually done via
  # a job similar to broadcast_append_later_to in `turbo_stream`
  # basically we call ActionCable.server.broadcast in that job
  # after_create { NotificationBroadcastJob.perform_later(self) }

  # lets just stream notification count
  # and upon clicking the dropdown, we load via lazy-loading unread notifications
  after_create_commit do
    broadcast_replace_later_to \
      "notifications #{self.recipient.id}", # => notifications_1
      Notification.for_user(self.recipient).unread.count
  end
  # after_create_commit do
    # broadcast_append_later_to \
      # ["notifications", self.recipient.id], # => notifications_1
      # target: "#{dom_id(recipient)}_messages",
      # partial: 'path/to/one/notification/partial',
      # locals: { message: self, notification_count: Notification.for_user(notification.recipient).count }
  # end

  def self.for_user(recipient)
    where(recipient: recipient)
  end
end

# notifiable.rb model concern
# this module is includable in any model
# eg in Contact model, has_many :notifications, or User model
# if the model has user_ids, then the NotificationSenderJob runs
# passing self
module Notifiable
  extend ActiveSupport::Concern

  included do
    # this appends to each place this odule is included
    has_many :notifications, as: :notifiable
    # not required since we donot want to send notification after user creation
    # we could just add `has_many :notifcation` to User model and  thats all
    # and use this concern for other models eg creation of group messages
    after_commit :send_notification_to_users
  end

  def send_notification_to_users
    if self.respond_to? :user_ids
      # NotificationSenderJob handles the saving of notification for each user
      # eg say you want to notify all group users
      # this job performs the saving itself
      NotificationSenderJob.perform_later(self)
    end
  end
end

# notification_broadcast_job.rb
#
class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    # we send the notification count to the user
    notification_count = Notification.for_user(notification.user)

    ActionCable.server.broadcast "notification.#{notification.user_id}", action: "new_notification", message: notification_count
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

# in config/application.rb
# config.active_job.queue_adapter = :sidekiq

# in config/routes.rb
# mount Sidekiq::Web => '/sidekiq

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
  # a channel streams from a particular channel
  # in this notification by current user
  # "notifications.1 where 1 is current_user.id
  def subscribed
    stream_from "notification.#{current_user.id}"
  end

  def unsubscribe
    # any cleanup
  end
end


# in the front end of the channel notification_channel.js
# to send push notifcation to the browser we could use pusher




# missing parts
# 1. when a contact request is created request is created,
#   we dispatch a notification
#   logic: models/contact_controller.rb
#   def create
#     # ...
#     if save
#       # extract this into a method that is reusable upon create to send
#       # a notification eg send_notification(@contact, contact) # contact is a single user or an array of user or ids
#       Notification.create! actor:current_user, recipient: contact, action: 'create', notifiable: @contact
#     end
#   end
#
#   example method in a concern mayb:
#
#   dispatch_notification(@contact)
#   def dispatch_notification(notifiable, action = params[:action]) # may be create, update, destroy etc
#       Notification.create! actor:current_user, recipient: contact, action: action', notifiable: @contact
#   end
#
#
# 2. Enable turbo_stream_tag in the notification bar only(header)
#   <%= turbo_stream_from "notification.#{current_user.id}", %>
#   see the update `after_create_commit callback in the notification.rb model file
#
# 3. For rendering individual notification
#   eg: <Joe> sent you a <contact> request, <Karis> joined <Hotwire and Rails Group>
#   borrow login like that in public activity feed
#   In index.html.erb
#
#   @notifications.each do |notification|
#     <%= div_for notification do %>
#       <%= link_to notification.actor.name, notification.actor %> # link to a user
#       <%= render "notifications/#{notification.notifiable_type.underscore}/#{notification,action}", notification: notification %> # "notifications/contact/create"
#     <% end %>
#   end
#
#   # this is required for each type that requires a notification
#   create views/notifications/contact/_create.html.erb
#   => `sent you a <%= link_to "contact request", # link to private conversation `
#
#
# 4. In depth refactoring
#   in create.html.erb: to avoid notification.notifiable eg to get post or comment
