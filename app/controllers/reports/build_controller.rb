class Reports::BuildController < ApplicationController
  include Wicked::Wizard

  steps :general, :customer, :symptoms, :team_members, :problem, :containment_actions, :root_cause, :corrective_actions, :preventive_actions, :recommendation, :recognition

  def show
    @organization = Current.user.organization
    @report = Report.find(params[:report_id])
    render_wizard
  end

  def update
    @report = Report.find(params[:report_id])
    puts('updated')
    render_wizard @report
  end

end
