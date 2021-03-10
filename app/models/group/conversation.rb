class Group::Conversation < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages, class_name: 'Group::Message', foreign_key: 'conversation_id', dependent: :destroy
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  after_create :add_conversation_creator_to_users

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def add_user(user)
    users << user unless users.include?(user)
  end

  private
    def add_conversation_creator_to_users
      users << creator
    end
end
