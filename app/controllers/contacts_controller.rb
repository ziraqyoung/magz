class ContactsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def create
    @contact = current_user.contacts.create!(contact_id: params[:contact_id])

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: "Contact request has been sent, you will be notified when is is accepted") }
    end
  end

  def update
  end

  def destroy
  end
end
