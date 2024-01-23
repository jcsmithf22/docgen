# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_23_154858) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_memberships", force: :cascade do |t|
    t.bigint "action_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_id"], name: "index_action_memberships_on_action_id"
    t.index ["user_id"], name: "index_action_memberships_on_user_id"
  end

  create_table "actions", force: :cascade do |t|
    t.bigint "report_id", null: false
    t.bigint "organization_id", null: false
    t.bigint "team_id"
    t.bigint "user_id", null: false
    t.bigint "root_cause_id"
    t.string "title"
    t.text "description"
    t.text "verification_description"
    t.text "validation_description"
    t.text "notes"
    t.date "due_date"
    t.date "verified_date"
    t.date "implemented_date"
    t.date "validated_date"
    t.date "removed_date"
    t.boolean "verified"
    t.boolean "implemented"
    t.boolean "validated"
    t.boolean "removed"
    t.integer "lock_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "action_type"
    t.index ["organization_id"], name: "index_actions_on_organization_id"
    t.index ["report_id"], name: "index_actions_on_report_id"
    t.index ["root_cause_id"], name: "index_actions_on_root_cause_id"
    t.index ["team_id"], name: "index_actions_on_team_id"
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attached_type", null: false
    t.bigint "attached_id", null: false
    t.index ["attached_type", "attached_id"], name: "index_attachments_on_attached"
  end

  create_table "errors", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_errors_on_organization_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email"
    t.bigint "organization_id", null: false
    t.string "token"
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_invitations_on_organization_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_products_on_organization_id"
  end

  create_table "report_memberships", force: :cascade do |t|
    t.bigint "report_id", null: false
    t.bigint "user_id"
    t.string "role"
    t.string "name"
    t.string "department"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "exists"
    t.index ["report_id"], name: "index_report_memberships_on_report_id"
    t.index ["user_id"], name: "index_report_memberships_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "report_id"
    t.bigint "organization_id", null: false
    t.bigint "team_id"
    t.bigint "user_id", null: false
    t.string "title"
    t.string "status"
    t.string "step_status"
    t.date "step_status_date"
    t.string "next_target_step"
    t.date "next_target_date"
    t.bigint "site_raised_by_id"
    t.bigint "site_responsible_id"
    t.bigint "product_id"
    t.string "part_number"
    t.bigint "error_id"
    t.string "material_code"
    t.integer "order_quantity"
    t.integer "defect_quantity"
    t.string "complaint_number"
    t.string "customer_id"
    t.string "customer_name"
    t.string "company_address"
    t.string "customer_type"
    t.string "internal_sales_order_number"
    t.string "customer_po"
    t.string "problem_statement"
    t.text "problem_description"
    t.date "recommendation_date"
    t.text "recommendation"
    t.date "recognition_date"
    t.text "recognition"
    t.integer "lock_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "completion"
    t.index ["error_id"], name: "index_reports_on_error_id"
    t.index ["organization_id"], name: "index_reports_on_organization_id"
    t.index ["product_id"], name: "index_reports_on_product_id"
    t.index ["site_raised_by_id"], name: "index_reports_on_site_raised_by_id"
    t.index ["site_responsible_id"], name: "index_reports_on_site_responsible_id"
    t.index ["team_id"], name: "index_reports_on_team_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "root_causes", force: :cascade do |t|
    t.bigint "report_id", null: false
    t.bigint "organization_id", null: false
    t.text "title"
    t.text "statement"
    t.text "description"
    t.text "verification_description"
    t.text "notes"
    t.date "verified_date"
    t.boolean "verified"
    t.integer "lock_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_root_causes_on_organization_id"
    t.index ["report_id"], name: "index_root_causes_on_report_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_sites_on_organization_id"
  end

  create_table "symptoms", force: :cascade do |t|
    t.bigint "report_id", null: false
    t.bigint "organization_id", null: false
    t.string "symptom"
    t.text "description"
    t.integer "lock_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_symptoms_on_organization_id"
    t.index ["report_id"], name: "index_symptoms_on_report_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.index ["organization_id"], name: "index_teams_on_organization_id"
    t.index ["owner_id"], name: "index_teams_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.string "role"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  add_foreign_key "action_memberships", "actions"
  add_foreign_key "action_memberships", "users"
  add_foreign_key "actions", "organizations"
  add_foreign_key "actions", "reports"
  add_foreign_key "actions", "root_causes"
  add_foreign_key "actions", "teams"
  add_foreign_key "actions", "users"
  add_foreign_key "errors", "organizations"
  add_foreign_key "invitations", "organizations"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "products", "organizations"
  add_foreign_key "report_memberships", "reports"
  add_foreign_key "report_memberships", "users"
  add_foreign_key "reports", "errors"
  add_foreign_key "reports", "organizations"
  add_foreign_key "reports", "products"
  add_foreign_key "reports", "sites", column: "site_raised_by_id"
  add_foreign_key "reports", "sites", column: "site_responsible_id"
  add_foreign_key "reports", "teams"
  add_foreign_key "reports", "users"
  add_foreign_key "root_causes", "organizations"
  add_foreign_key "root_causes", "reports"
  add_foreign_key "sessions", "users"
  add_foreign_key "sites", "organizations"
  add_foreign_key "symptoms", "organizations"
  add_foreign_key "symptoms", "reports"
  add_foreign_key "teams", "organizations"
  add_foreign_key "teams", "users", column: "owner_id"
  add_foreign_key "users", "organizations"
end
