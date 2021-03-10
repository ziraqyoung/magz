class Group::MessagesController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :set_conversation

  include ActionView::RecordIdentifier


  def create
    @group_message = @group_conversation.messages.build(group_message_params)
    @group_message.user = current_user

    respond_to do |format|
      if @group_message.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_group_message",
            partial: 'group/messages/form', locals: { message: Group::Message.new }
          )
        end

        format.html { redirect_to @group_conversation }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            @group_message,
            partial: 'group/messages/form', locals: { message: @group_message }
          )
        end
        format.html { render @group_conversation }
      end
    end
  end

  private
    def set_conversation
      @group_conversation = Group::Conversation.find(params[:group_conversation_id])
    end

    def group_message_params
      params.require(:group_message).permit(:message_body)
    end
end
