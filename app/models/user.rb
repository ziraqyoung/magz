class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :private_messages, class_name: 'Private::Message'
  has_many :private_conversations, foreign_key: :sender_id, class_name: 'Private::Conversation'

  # contacts is a join model, (allows has_many :through)
  has_many :contacts
  has_many :all_received_contact_requests, class_name: 'Contact', foreign_key: 'contact_id'

  has_many :accepted_sent_contact_requests,
           -> { where(contacts: { accepted: true }) },
           through: :contacts, source: :contact
  has_many :accepted_received_contact_requests,
           -> { where(contacts: { accepted: true }) },
           through: :all_received_contact_requests, source: :user

  has_many :pending_sent_contact_requests,
           -> { where(contacts: { accepted: false }) },
           through: :contacts, source: :contact

  has_many :accepted_received_contact_requests,
           -> { where(contacts: { accepted: true }) },
           through: :all_received_contact_requests, source: :user
  has_many :pending_received_contact_requests,
           -> { where(contacts: { accepted: false }) },
           through: :all_received_contact_requests, source: :user


  has_many :group_messages, class_name: 'Group::Message'
  has_and_belongs_to_many :group_conversations, class_name: 'Group::Conversation'
  has_many :created_group_conversations, class_name: 'Group::Conversation'

  has_many :notifications, foreign_key: :recipient_id

  # gets all your contacs
  def all_active_contacts
    accepted_sent_contact_requests | accepted_received_contact_requests
  end

  # gets all pending sent and receives contacts
  def pending_contacts
    pending_sent_contact_requests | pending_received_contact_requests
  end

  # gets a Contact record
  def contact(contact)
    Contact.where(user: self, contact: contact)[0]
  end
end
