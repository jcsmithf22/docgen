# frozen_string_literal: true

class Reports::BuildController < ApplicationController
  include Wicked::Wizard

  steps :general, :customer, :symptoms, :team_members, :problem, :containment_actions, :root_causes,
        :corrective_actions, :prevent_actions, :recommendation, :recognition

  def show
    @organization = Current.user.organization
    @report = Report.includes(:symptoms, :report_memberships, :root_causes,
                              actions: :action_memberships).find(params[:report_id])

    handle_step

    render_wizard
  end

  def update
    @report = Report.includes(:symptoms, :report_memberships, :root_causes,
                              actions: :action_memberships).find(params[:report_id])
    @report.update(report_params)
    @organization = Current.user.organization

    populate_instance_variables unless @report.valid?

    flash.now.alert = 'Please fill out all required fields' unless @report.errors.empty?
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
      :completion,
      symptoms_attributes: %i[id organization_id symptom description lock_version _destroy],
      report_memberships_attributes: %i[id user_id role name department email phone exists _destroy],
      root_causes_attributes: %i[id organization_id title statement description verification_description notes
                                 verified_date verified lock_version _destroy],
      actions_attributes: [
        :id, :title, :description, :verification_description, :validation_description,
        :notes, :due_date, :verified_date, :implemented_date, :validated_date,
        :removed_date, :verified, :implemented, :validated, :removed,
        :lock_version, :organization_id, :team_id, :user_id, :root_cause_id, :action_type,
        :_destroy, { action_memberships_attributes: %i[id user_id _destroy] }
      ]
    )
  end

  private

  def handle_step
    case step
    when :general
      load_general
    when :symptoms
      init_symptoms if @report.symptoms.empty?
    when :team_members
      load_users
      init_report_members if @report.report_memberships.empty?
    when :containment_actions
      init_containment_action if @report.actions.none?(&:ica?)
      load_users
    when :root_causes
      init_root_causes if @report.root_causes.empty?
    when :corrective_actions
      init_corrective_action if @report.actions.none?(&:pca?)
      load_users
      load_root_causes
    when :prevent_actions
      init_prevent_action if @report.actions.none?(&:pra?)
      load_users
      load_root_causes
    end
  end

  def populate_instance_variables
    case step
    when :general
      load_general
    when :team_members, :containment_actions
      load_users
    when :corrective_actions, :prevent_actions
      load_users
      load_root_causes
    end
  end

  def load_general
    @sites = @organization.sites
    @errors = @organization.error_codes
    @products = @organization.products
  end

  def load_users
    @users = @organization.users
  end

  def load_root_causes
    @root_causes = @report.root_causes
  end

  def init_symptoms
    @report.symptoms.build
  end

  def init_report_members
    @report.report_memberships.build
  end

  def init_containment_action
    action = @report.actions.build(action_type: :ica)
    action.action_memberships.build
  end

  def init_root_causes
    @report.root_causes.build
  end

  def init_corrective_action
    action = @report.actions.build(action_type: :pca)
    action.action_memberships.build
  end

  def init_prevent_action
    action = @report.actions.build(action_type: :pra)
    action.action_memberships.build
  end

end
