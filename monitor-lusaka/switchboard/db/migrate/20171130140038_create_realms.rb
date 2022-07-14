class CreateRealms < ActiveRecord::Migration[5.1]
  def change
    create_table :realms, id: :uuid do |t|
      t.string :domain_name, uniqueness: true
      t.belongs_to :organisation, type: :uuid, foreign_key: true, on_update: :cascade, on_delete: :restrict
      t.string :test_user
      t.string :test_password
      t.boolean :generic, null:false, default: false

      t.timestamps null: false
    end
  end
end
