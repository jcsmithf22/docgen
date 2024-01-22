class CreateAttachments < ActiveRecord::Migration[7.1]
  def change
    create_table :attachments do |t|
      t.references :report, null: true, foreign_key: true
      t.references :root_cause, null: true, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
