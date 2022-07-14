class CreateOrganisations < ActiveRecord::Migration[5.1]
  def change
    create_table :organisations, id: :uuid do |t|
      t.string :name, null: false
      t.references :federation, type: :uuid
      t.string :country_code, limit: 2, null: false   #country
      t.uuid :identifier, uniqueness: true, null: false, default: 'gen_random_uuid()'          # inst_id
      t.string :eduroam_type, null: false
      t.string :venue_type
      t.integer :stage, default: 1, null: false
      t.string :info_url, null: false
      t.string :policy_url, null: false
      t.string :language, null: false, default: 'en'

      t.timestamps null: false
    end
  end
end
