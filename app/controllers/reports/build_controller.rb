class Reports::BuildController < ApplicationController
  include Wicked::Wizard

  steps :general, :customer, :symptoms, :team_members, :problem, :containment_actions, :root_cause, :corrective_actions, :preventive_actions, :recommendation, :recognition

  def show
    @organization = Current.user.organization
    case step
    when :general
      @sites = @organization.sites
      @errors = @organization.error_codes
      @products = @organization.products
    else
      # do nothing
    end
    @report = Report.find(params[:report_id])
    render_wizard
  end

  def update
    @report = Report.find(params[:report_id])
    @report.update(report_params)
    @organization = Current.user.organization
    case step
    when :general
      unless @report.valid?
        @sites = @organization.sites
        @errors = @organization.error_codes
        @products = @organization.products
      end
    else
      # do nothing
    end
    render_wizard @report
  end

  def report_params
    params.require(:report).permit(
      :report_id,
      :organization_id,
      :team_id,
      :user_id,
      :title,
      :status,
      :step_status,
      :step_status_date,
      :next_target_step,
      :next_target_date,
      :site_raised_by_id,
      :site_responsible_id,
      :product_id,
      :part_number,
      :error_id,
      :material_code,
      :order_quantity,
      :defect_quantity,
      :complaint_number,
      :customer_id,
      :customer_name,
      :company_address,
      :customer_type,
      :internal_sales_order_number,
      :customer_po,
      :problem_statement,
      :problem_description,
      :recommendation_date,
      :recommendation,
      :recognition_date,
      :recognition,
      :lock_version,
      :completion
    )
  end

end
