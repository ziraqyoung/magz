module Group::ConversationsHelper
  def join_group_partial_path(user)
    if @group_conversation.users.include?(user)
      'group/messages/form'
    else
      'group/conversations/show/join_group'
    end
  end
end
