class Reports::BuildController < ApplicationController
  include Wicked::Wizard

  steps :general, :customer, :symptoms, :team_members, :problem, :containment_actions, :root_causes, :corrective_actions, :prevent_actions, :recommendation, :recognition

  def show
    @organization = Current.user.organization
    @report = Report.includes(:symptoms, :report_memberships, :root_causes, actions: :action_memberships).find(params[:report_id])
    case step
    when :general
      @sites = @organization.sites
      @errors = @organization.error_codes
      @products = @organization.products
    when :symptoms
      # If the report has no symptoms, initialize at least one for the form
      @report.symptoms.build if @report.symptoms.empty?
    when :team_members
      @users = @organization.users
      @report.report_memberships.build if @report.report_memberships.empty?
    when :containment_actions
      # build a default action if the report has no actions of type ica
      if @report.actions.none? { |a| a.ica? }
        action = @report.actions.build(action_type: :ica)
        action.action_memberships.build
      end
      @users = @organization.users
    when :root_causes
      @report.root_causes.build if @report.root_causes.empty?
    when :corrective_actions
      if @report.actions.none? { |a| a.pca? }
        action = @report.actions.build(action_type: :pca)
        action.action_memberships.build
      end
      @users = @organization.users
      @root_causes = @report.root_causes
    when :prevent_actions
      if @report.actions.none? { |a| a.pra? }
        action = @report.actions.build(action_type: :pra)
        action.action_memberships.build
      end
      @users = @organization.users
      @root_causes = @report.root_causes
    else
      # do nothing
    end
    render_wizard
  end

  def update
    puts(params)
    @report = Report.includes(:symptoms, :report_memberships, :root_causes, actions: :action_memberships).find(params[:report_id])
    @report.update(report_params)
    @organization = Current.user.organization
    case step
    when :general
      unless @report.valid?
        @sites = @organization.sites
        @errors = @organization.error_codes
        @products = @organization.products
      end
    when :team_members
      unless @report.valid?
        @users = @organization.users
      end
    when :containment_actions
      unless @report.valid?
        @users = @organization.users
      end
    when :corrective_actions
      unless @report.valid?
        @users = @organization.users
        @root_causes = @report.root_causes
      end
    when :prevent_actions
      unless @report.valid?
        @users = @organization.users
        @root_causes = @report.root_causes
      end
    else
      # do nothing
    end
    flash.now.alert = 'Please fill out all required fields' unless @report.errors.empty?
    render_wizard @report
  end

  def add_symptom
    @report = Report.find(params[:report_id])
    @report.symptoms.build
    respond_to do |format|
      format.turbo_stream
    end
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
      symptoms_attributes: [:id, :organization_id, :symptom, :description, :lock_version, :_destroy],
      report_memberships_attributes: [:id, :user_id, :role, :name, :department, :email, :phone, :exists, :_destroy],
      root_causes_attributes: [:id, :organization_id, :title, :statement, :description, :verification_description, :notes, :verified_date, :verified, :lock_version, :_destroy],
      actions_attributes: [
        :id, :title, :description, :verification_description, :validation_description,
        :notes, :due_date, :verified_date, :implemented_date, :validated_date,
        :removed_date, :verified, :implemented, :validated, :removed,
        :lock_version, :organization_id, :team_id, :user_id, :root_cause_id, :action_type,
        :_destroy, action_memberships_attributes: [:id, :user_id, :_destroy]
      ]
    )
  end

end
