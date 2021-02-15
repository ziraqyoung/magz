module Private::ConversationsHelper
  include Private::MessagesHelper

  def private_conv_recipient(conversation)
    conversation.opposed_user(current_user)
  end
end
