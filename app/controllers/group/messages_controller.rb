class Group::MessagesController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :set_conversation


  def create
    @group_message = @group_conversation.messages.build(group_message_params)
    @group_message.user = current_user


  end

  private
    def set_conversation
      @group_conversation = Group::Conversation.find(params[:id])
    end

    def group_message_params
      params.require(:group_message).permit(:content)
    end
end
