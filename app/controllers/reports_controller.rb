# frozen_string_literal: true

class ReportsController < ApplicationController

  def index
    @organization = Current.user.organization
    @reports = Report.includes(:user).where(organization_id: @organization.id).order(updated_at: :desc).to_a
    @personal_reports = @reports.select { |r| r.user_id == Current.user.id }
  end

  def create
    report_id = Report.next_report_id(Current.user.organization_id)
    @report = Report.create(organization_id: Current.user.organization_id, user: Current.user, report_id:)

    redirect_to report_build_path(report_id: @report.id, id: :general)
  end

  def destroy
    # first delete all actions for the report
    actions = Action.includes(:action_memberships).where(report_id: params[:id])
    actions.destroy_all

    # delete all attachments

    report = Report.includes(:symptoms, :report_memberships, :attachments, :actions,
                             root_causes: %i[actions attachments]).find(params[:id])
    # report = Report.find(params[:id])
    report.destroy

    redirect_to root_path, notice: 'Report has been deleted'
  end
end
