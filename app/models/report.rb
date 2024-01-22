class Report < ApplicationRecord
  belongs_to :organization
  belongs_to :team, optional: true
  belongs_to :user
  belongs_to :site_raised_by, class_name: "Site", optional: true
  belongs_to :site_responsible, class_name: "Site", optional: true
  belongs_to :product, optional: true
  belongs_to :error, optional: true

  # For right now, destroy dependent records if report is deleted
  has_many :attachments, as: :attached, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :root_causes, dependent: :destroy
  has_many :symptoms, dependent: :destroy
  has_many :report_memberships, dependent: :destroy

  enum completion: { one: "general", two: "customer complaint", three: "D0", four: "D1", five: "D2", six: "D3", seven: "D4", eight: "D5", nine: "D6", ten: "D7", eleven: "D8", complete: "complete" }

  # We are using a wizard to fill out the report, so we need to validate the presence of the fields in each step

  # Step 1: General Information
  validates :title, :status, :step_status, :step_status_date, :next_target_step, :next_target_date, :site_raised_by_id, :site_responsible_id, :product_id, :error_id, :material_code, :order_quantity, :defect_quantity, :complaint_number, presence: true, if: :step_one?

  # Step 2: Customer Information
  validates :customer_id, :customer_name, :company_address, :customer_type, :internal_sales_order_number, :customer_po, presence: true, if: :step_two?

  # Step 3: Symptoms and Emergency response actions. This is a nested form, and a different model. Validations will take place in the Symptoms model

  # Step 4: Team members (Report memberships model)

  # Step 5: Problem
  validates :problem_statement, :problem_description, presence: true, if: :step_five?

  # Steps 6, 7, 8 and 9 are nested forms, and different models. Validations will take place in the Root Cause model and Action model

  # Step 10: Recommendation
  validates :recommendation_date, :recommendation, presence: true, if: :step_ten?

  # Step 11: Recognition
  validates :recognition_date, :recognition, presence: true, if: :step_eleven?

  def completed?
    self.complete?
  end

  def step_one?
    self.one? || completed?
  end

  def step_two?
    self.two? || completed?
  end

  def step_five?
    self.five? || completed?
  end

  def step_ten?
    self.ten? || completed?
  end

  def step_eleven?
    self.eleven? || completed?
  end

  def self.next_report_id(organization_id)
    last_report = Report.where(organization_id: organization_id).order(report_id: :desc).first
    last_report ? last_report.report_id + 1 : 1
  end

end
