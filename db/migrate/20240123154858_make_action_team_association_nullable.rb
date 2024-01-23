class MakeActionTeamAssociationNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :actions, :team_id, true
    add_column :actions, :action_type, :string
  end
end
