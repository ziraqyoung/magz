class Private::Conversations::MessagesController < ApplicationController
  include Messagable

  before_action :set_messagable

  private
    def set_messagable
      @messagable = Private::Conversation.find(params[:conversation_id])
    end
end
