class AddDomainNameToOrganisation < ActiveRecord::Migration[5.2]
  def change
    add_column :organisations, :domain_name, :string, null: false
  end
end
