class ChangeOwnerInTeams < ActiveRecord::Migration[7.1]
  def change
    remove_column :teams, :owner, :string
    add_reference :teams, :owner, foreign_key: { to_table: :users, null: false }
  end
end
