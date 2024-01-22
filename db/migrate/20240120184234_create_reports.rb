class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.integer :report_id
      t.references :organization, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :status
      t.string :step_status
      t.date :step_status_date
      t.string :next_target_step
      t.date :next_target_date
      t.references :site_raised_by, null: false
      t.references :site_responsible, null: false
      t.references :product, null: false, foreign_key: true
      t.string :part_number
      t.references :error, null: false, foreign_key: true
      t.string :material_code
      t.integer :order_quantity
      t.integer :defect_quantity
      t.string :complaint_number
      t.string :customer_id
      t.string :customer_name
      t.string :company_address
      t.string :customer_type
      t.string :internal_sales_order_number
      t.string :customer_po
      t.string :problem_statement
      t.string :problem_description
      t.date :recommendation_date
      t.text :recommendation
      t.date :recognition_date
      t.text :recognition
      t.integer :lock_version

      t.timestamps
    end
    add_foreign_key :reports, :sites, column: :site_raised_by_id
    add_foreign_key :reports, :sites, column: :site_responsible_id
  end
end
