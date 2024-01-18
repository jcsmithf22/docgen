class AddOwnerToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :owner, :string
  end
end
