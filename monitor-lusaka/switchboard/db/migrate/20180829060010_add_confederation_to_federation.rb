class AddConfederationToFederation < ActiveRecord::Migration[5.2]
  def change
    add_reference :federations, :confederation, type: :uuid, foreign_key: true
  end
end
