class ReportsController < ApplicationController
  def create
    report_id = Report.next_report_id(Current.user.organization_id)
    @report = Report.create(organization_id: Current.user.organization_id, user: Current.user, report_id: report_id)

    redirect_to report_build_path(report_id: @report.id, id: :general)
  end

  def destroy
    # first delete all actions for the report
    actions = Action.includes(:action_memberships).where(report_id: params[:id])
    actions.destroy_all

    report = Report.includes(:symptoms, :report_memberships, :attachments, :actions, root_causes: [:actions, :attachments]).find(params[:id])
    # report = Report.find(params[:id])
    report.destroy

    redirect_to root_path, notice: 'Report has been deleted'
  end
end
