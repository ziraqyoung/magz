class NotificationsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @notifications = current_user.notifications.unread
  end

  def create
  end
end
