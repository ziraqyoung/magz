class CreateGroupConversationsUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :group_conversations_users,  id: false do |t|
      t.integer :conversation_id, null: false, index: true
      t.integer :user_id, null: false, index: true
    end

    add_index :group_conversations_users, [:conversation_id, :user_id], unique: true
    add_index :group_conversations_users, [:user_id, :conversation_id], unique: true
  end
end
