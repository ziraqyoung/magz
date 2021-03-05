class CreateGroupMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :group_messages do |t|
      t.string :content, null: false
      t.string :added_new_users
      t.string :seen_by
      t.references :user, index: true, foreign_key: true
      t.belongs_to :conversation, index: true

      t.timestamps
    end
  end
end
