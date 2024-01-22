class AddOrganizationToSites < ActiveRecord::Migration[7.1]
  def change
    add_reference :sites, :organization, null: false, foreign_key: true
  end
end
