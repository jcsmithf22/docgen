class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.string :email
      t.references :organization, null: false, foreign_key: true
      t.string :token
      t.boolean :accepted

      t.timestamps
    end
  end
end
