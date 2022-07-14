class CreateRadiusServers < ActiveRecord::Migration[5.1]
  def change
    create_table :radius_servers, id: :uuid do |t|
      t.belongs_to :radiusable, type: :uuid, polymorphic: true, index: true, on_update: :cascade, on_delete: :cascade
      t.string :name, null: false
      t.string :server_type, null: false
      t.string :product
      t.inet :ip4
      t.inet :ip6
      t.macaddr :mac
      t.string :protocol, null: false
      t.string :upstream_secret
      t.string :monitor_secret
      t.string :switchboard_secret
      t.boolean :require_message_authenticator, default: true, null: false
      t.boolean :auth, default: true, null: false
      t.boolean :acct, default: true, null: false
      t.integer :auth_port, default: 1812, null: false
      t.integer :acct_port, default: 1813, null: false

      t.timestamps null: false
    end
  end
end
