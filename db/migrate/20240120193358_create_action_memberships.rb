class CreateActionMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :action_memberships do |t|
      t.references :action, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
