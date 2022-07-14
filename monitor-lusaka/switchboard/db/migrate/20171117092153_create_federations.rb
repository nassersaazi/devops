class CreateFederations < ActiveRecord::Migration[5.1]
  def change
    create_table :federations, id: :uuid do |t|
      t.belongs_to :operator, type: :uuid, index: true, foreign_key: { to_table: :organisations }, on_update: :cascade, on_delete: :cascade
      t.integer :stage, default: 1, null: false
      t.string :email, null: false
      t.string :identifier, uniqueness: true
      t.string :tld, null: false, uniqueness: true
      t.string :info_url, null: false
      t.string :policy_url, null: false
      t.string :language, null: false, default: 'en'

      t.timestamps null: false
    end
  end
end
