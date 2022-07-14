class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts, id: :uuid do |t|
      t.belongs_to :contactable, type: :uuid, polymorphic: true, index: true, on_update: :cascade, on_delete: :cascade
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.integer :contact_type, limit: 1, null: false, default: 0
      t.integer :privacy, limit: 1, null: false, default: 0

      t.timestamps null: false
    end
  end
end
