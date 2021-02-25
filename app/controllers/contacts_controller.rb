class ContactsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :set_recipient

  def create
    @contact = current_user.contacts.create!(contact_id: params[:contact_id])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path, notice: "Contact request has been sent, you will be notified when is is accepted") }
    end
  end

  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update(accepted: true)
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path, notice: "Contact request accepted") }
      else
        format.html { redirect_back(fallback_location: root_path, notice: "Contact request not accepted") }
      end
    end
  end

  def destroy
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.destroy
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path, notice: "Contact request declined") }
      else
        format.html { redirect_back(fallback_location: root_path, notice: "Contact request not declined") }
      end
    end
  end

  private
    def set_recipient
      conversation = Private::Conversation.find(params[:conversation_id])
      @recipient = conversation.opposed_user(current_user)
    end
end
