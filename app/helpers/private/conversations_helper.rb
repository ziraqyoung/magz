module Private::ConversationsHelper
  include Private::MessagesHelper

  def private_conv_recipient(conversation)
    conversation.opposed_user(current_user)
  end

  def add_to_contacts_partial_path(contact)
    if recipient_is_contact?
      'private/conversations/show/heading/already_in_contacts'
    else
      non_contact(contact)
    end
  end

  def get_contact_record(recipient)
    Contact.find_by_users(current_user.id, recipient.id)
  end

  def unaccepted_contact_request_partial_path(contact)
    if unaccepted_contact_exists(contact)
      if request_sent_by_user(contact)
        # if contact request was sent by user or recipient
        'private/conversations/show/request_status/sent_by_current_user'
      else
        'private/conversations/show/request_status/sent_by_recipient'
      end
    else
      # contact request was not sent by any user
      'shared/empty_partial'
    end
  end

  def not_contact_no_request_partial_path(contact)
    if recipient_is_contact? == false && unaccepted_contact_exists(contact) == false
      'private/conversations/show/request_status/send_request'
    else
      'shared/empty_partial'
    end
  end

  private

    def recipient_is_contact?
      # assumes @recipient is already set in the partial
      current_user.all_active_contacts.include? @recipient
    end

    def non_contact(contact)
      if unaccepted_contact_exists(contact)
        if request_sent_by_user(contact)
          # if contact request was sent by user or recipient
          'private/conversations/show/heading/pending_contact_request'
        else
          'private/conversations/show/heading/accept_contact_request'
        end
      else
        # contact request was not sent by any user
        'private/conversations/show/heading/add_user_to_contacts'
      end
    end

    def request_sent_by_user(contact)
      # true if the contact request was sent by current user
      # false if sent by recipient
      contact['user_id'] == current_user.id
    end

    def unaccepted_contact_exists(contact)
      # get a contact status with the recipient
      if contact.present?
        # check if unaccepted contact between user and recipient exist
        contact.accepted ? false : true
      else
        false
      end
    end
end
