class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships, id: :uuid do |t|
      t.references :user, foreign_key: true
      t.references :organisation, foreign_key: true, type: :uuid
      t.boolean :operator, default: false, null: false

      t.timestamps null: false
    end
  end
end
