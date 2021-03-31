module SaveNotification
  extend ActiveSupport::Concern

  def save_notification(notifiable, recipient, action: params[:action])
    Notification.create! actor: current_user, recipient: recipient, action: action, notifiable: notifiable
  end
end
