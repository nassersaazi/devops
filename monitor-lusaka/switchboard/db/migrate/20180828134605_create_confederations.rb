class CreateConfederations < ActiveRecord::Migration[5.2]
  def change
    create_table :confederations, id: :uuid do |t|
      t.string :name
      t.belongs_to :operator, type: :uuid, index: true, foreign_key: { to_table: :organisations }, on_update: :cascade, on_delete: :restrict
      t.string :email
      t.string :tld, uniqueness: true

      t.timestamps
    end
  end
end
