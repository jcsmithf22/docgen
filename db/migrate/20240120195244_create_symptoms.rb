class CreateSymptoms < ActiveRecord::Migration[7.1]
  def change
    create_table :symptoms do |t|
      t.references :report, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :symptom
      t.text :description
      t.integer :lock_version

      t.timestamps
    end
  end
end
