module Messagable
  extend ActiveSupport::Concern
  include ActionView::RecordIdentifier

  included do
    before_action :authenticate_user!
  end

  def create
    @message = @messagable.messages.new(message_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        message = @messagable.messages.new
        message.user = current_user

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            dom_id(@messagable),
            partial: 'private/messages/form', locals: { messagable: @messagable, message: message }
          )
        end

        format.html { redirect_to @messagable }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            dom_id(@messagable),
            partial: 'private/messages/form', locals: { messagable: @messagable, message: @message }
          )
        end
        format.html { redirect_to @messagable }
      end
    end
  end

  private
    def message_params
      params.require(:private_message).permit(:message_body)
    end
end
