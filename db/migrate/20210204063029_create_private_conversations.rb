class CreatePrivateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :private_conversations do |t|
      t.references :sender, index: true 
      t.references :recipient, index: true

      t.timestamps
    end

    add_index :private_conversations, [:recipient_id, :sender_id], unique: true
  end
end
