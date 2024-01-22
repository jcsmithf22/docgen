class AddOrganizationToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :organization, null: false, foreign_key: true
  end
end
