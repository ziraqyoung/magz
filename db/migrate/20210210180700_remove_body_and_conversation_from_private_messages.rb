class RemoveBodyAndConversationFromPrivateMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :private_messages, :body, :text
    remove_column :private_messages, :conversation_id, index: true
  end
end
