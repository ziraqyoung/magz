class NotificationsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @unread_notifications = Notification.new_for_user(current_user.id)
    @read_notifications = Notification.read_for_user(current_user.id)
  end
end
