class Private::ConversationsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @conversations = Private::Conversation.where(sender: current_user).or(Private::Conversation.where(recipient: current_user))
  end

  def show
    @conversation = Private::Conversation.includes(:sender, :recipient, :messages).find(params[:id])
  end

  def create
    post = Post.find(params[:post_id])
    recipient_id = post.user.id
    @conversation = Private::Conversation.new(sender_id: current_user.id, recipient_id: recipient_id)

    if @conversation.save
      @conversation.messages.create message_body: params[:message_body], user: current_user

      respond_to do |format|
        format.html { redirect_to post, success: 'Message has been sent' }
      end
    else
      respond_to do |format|
        format.html { redirect_to post, alert: 'Message has not been sent' }
      end
    end
  end
end
