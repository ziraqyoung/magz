class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.belongs_to :contact, index: true
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
