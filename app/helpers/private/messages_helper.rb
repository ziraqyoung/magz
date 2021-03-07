module Private::MessagesHelper
  def private_message_date_check(message, previous_message)
    if defined?(previous_message) && previous_message.present?
      # if messages are not created on the same day
      if previous_message.created_at.to_date != message.created_at.to_date
        @message = message
        'private/messages/message/new_date'
      else
        'shared/empty_partial'
      end
    else
      'shared/empty_partial'
    end
  end
end
