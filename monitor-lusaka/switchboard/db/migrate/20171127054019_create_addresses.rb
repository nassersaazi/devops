class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :addressable, polymorphic: true, index: true, type: :uuid, on_update: :cascade, on_delete: :cascade
      t.string :street
      t.string :street2
      t.string :pobox
      t.string :city
      t.string :zip
      t.string :state
      t.string :country_code, limit: 2, null: false
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :altitude

      t.timestamps null: false
    end
  end
end
