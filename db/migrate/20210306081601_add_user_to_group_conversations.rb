class AddUserToGroupConversations < ActiveRecord::Migration[6.1]
  def change
    add_reference :group_conversations, :user, null: false, foreign_key: true
  end
end
