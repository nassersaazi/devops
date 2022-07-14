class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations, id: :uuid do |t|
      t.belongs_to :organisation, type: :uuid, foreign_key: true, on_update: :cascade, on_delete: :restrict
      t.string :name
      t.uuid :identifier, uniqueness: true, null: false, default: 'gen_random_uuid()'          # instid
      t.integer :stage, null: false, default: 1
      t.integer :transmission, null: false, default: 0
      t.string :venue_type
      t.string :ssid, null: false, default: 'eduroam'
      # t.references :address, type: :uuid, foreign_key: true
      # t.references :contacts, type: :uuid, foreign_key: true
      t.string :wpa_mode
      t.string :encryption_mode
      t.integer :ap_no, default: 1
      t.integer :wired_no, default: 1
      t.boolean :port_restrict
      t.boolean :transp_proxy
      t.boolean :ipv6
      t.boolean :nat
      t.boolean :hs20
      t.integer :availability, default: 0
      t.string :operation_hours, default: "Always"
      t.string :info_url

      t.timestamps null: false
    end
  end
end
