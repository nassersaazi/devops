class CreateEquipment < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment, id: :uuid do |t|
      t.string :name, null: false
      t.belongs_to :location, type: :uuid, foreign_key: true
      t.inet :ip4
      t.integer :prefix4, default: 32
      t.inet :ip6
      t.integer :prefix6, default: 128
      t.macaddr :mac
      t.string :protocol, null: false
      t.string :upstream_secret
      t.string :monitor_secret
      t.string :switchboard_secret
      t.boolean :require_message_authenticator, default: true, null: false
      t.string :nas_type, null: false
      t.string :nas_kind

      t.timestamps null: false
    end
  end
end
