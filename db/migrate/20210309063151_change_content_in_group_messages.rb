class ChangeContentInGroupMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :group_messages, :content, :message_body
  end
end
