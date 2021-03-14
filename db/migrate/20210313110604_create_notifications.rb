class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true, null: false
      t.integer :recipient_id, null: false
      t.integer :actor_id, null: false
      t.string :action
      t.datetime :read_at, default: nil

      t.timestamps
    end
    add_index :notifications, :recipient_id
  end
end
