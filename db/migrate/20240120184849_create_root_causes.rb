class CreateRootCauses < ActiveRecord::Migration[7.1]
  def change
    create_table :root_causes do |t|
      t.references :report, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.text :title
      t.text :statement
      t.text :description
      t.text :verification_description
      t.text :notes
      t.date :verified_date
      t.boolean :verified
      t.integer :lock_version

      t.timestamps
    end
  end
end
