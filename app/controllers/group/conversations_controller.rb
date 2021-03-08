class Group::ConversationsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @group_conversations = Group::Conversation.all
  end

  def show
  end
end
