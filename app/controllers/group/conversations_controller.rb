class Group::ConversationsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @group_conversations = Group::Conversation.all
  end

  def show
    @group_conversation = Group::Conversation.find(params[:id])
  end

  def new
    @group_conversation = current_user.created_group_conversations.build
  end

  def create
    @group_conversation = current_user.created_group_conversations.build(group_conversation_params)

      if @group_conversation.save
        redirect_to @group_conversation, success: 'Group created successfully' 
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(@group_conversation, partial: 'group/conversations/form' )
          end
          format.html { flash.now[:warning] = "Not created!"; render :new }
        end
      end
  end

  def join
    @group_conversation = Group::Conversation.find(params[:id])
    @group_conversation.add_user(current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @group_conversation, success: 'Joined successfully' }
    end
  end

  private
    def group_conversation_params
      params.require(:group_conversation).permit(:name)
    end
end
