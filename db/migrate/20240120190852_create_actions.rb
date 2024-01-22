class CreateActions < ActiveRecord::Migration[7.1]
  def change
    create_table :actions do |t|
      t.references :report, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :root_cause, null: true, foreign_key: true
      t.string :title
      t.text :description
      t.text :verification_description
      t.text :validation_description
      t.text :notes
      t.date :due_date
      t.date :verified_date
      t.date :implemented_date
      t.date :validated_date
      t.date :removed_date
      t.boolean :verified
      t.boolean :implemented
      t.boolean :validated
      t.boolean :removed
      t.integer :lock_version

      t.timestamps
    end
  end
end
