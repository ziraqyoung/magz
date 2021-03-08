class Group::Conversation < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages, class_name: 'Group::Message', foreign_key: 'conversation_id', dependent: :destroy
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true
end
