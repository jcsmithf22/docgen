class UpdateAttachmentsForPolymorphism < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :attachments, :reports
    remove_foreign_key :attachments, :root_causes

    remove_column :attachments, :report_id, :bigint
    remove_column :attachments, :root_cause_id, :bigint

    add_reference :attachments, :attached, polymorphic: true, null: false
  end
end
