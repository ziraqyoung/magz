class CreateGroupConversationsUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :group_conversations_users,  id: false do |t|
      t.integer :conversation_id, null: false
      t.integer :user_id, null: false
    end

    add_index :group_conversations_users, :conversation_id
    add_index :group_conversations_users, :user_id
  end
end
