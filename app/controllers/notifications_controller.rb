class NotificationsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @notifications = Notification.all
  end

  def create
  end
end
