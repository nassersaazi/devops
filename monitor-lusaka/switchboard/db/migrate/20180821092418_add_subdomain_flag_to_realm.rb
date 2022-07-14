class AddSubdomainFlagToRealm < ActiveRecord::Migration[5.2]
  def change
    add_column :realms, :allow_subdomains, :boolean, default: false
  end
end
