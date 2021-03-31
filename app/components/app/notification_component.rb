# frozen_string_literal: true

class App::NotificationComponent < ViewComponent::Base
  attr_reader :notification

  def initialize(notification)
    @notification = notification
  end

  def actor
    notification.actor
  end

  def render_partial_with_locals
    locals = {notification: notification}
    locals[notification.notifiable_type.underscore.to_sym] = notification.notifiable

    render partial_path, locals
  end

  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for notification in #{partial_paths}")
  end

  def partial_paths
    [
      "notifications/#{notification.notifiable_type.underscore}/#{notification.action}",
      "notifications/#{notification.notifiable_type.underscore}",
    ]
  end
end
