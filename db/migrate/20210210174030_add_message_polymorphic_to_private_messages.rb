class AddMessagePolymorphicToPrivateMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :private_messages, :messagable, polymorphic: true, null: false
  end
end
