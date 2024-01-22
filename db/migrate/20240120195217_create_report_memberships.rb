class CreateReportMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :report_memberships do |t|
      t.references :report, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :role
      t.string :name
      t.string :department
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
